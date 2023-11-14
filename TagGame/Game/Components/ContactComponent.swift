import GameplayKit

final class ContactComponent: GKComponent {
    
    private let category: PhysicsCategory
    private(set) var contactingEntity: GKEntity?
    
    init(shouldContactWith category: PhysicsCategory) {
        self.category = category
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didAddToEntity() {
        body?.contactTestBitMask = category.rawValue
    }
    
    override func willRemoveFromEntity() {
        body?.contactTestBitMask = 0
    }
}

// MARK: - API

extension ContactComponent {
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA == body {
            contactingEntity = contact.bodyB.node?.entity
        } else if contact.bodyB == body {
            contactingEntity = contact.bodyA.node?.entity
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        guard contact.bodyA == body || contact.bodyB == body else { return }
        contactingEntity = nil
    }
    
    private var body: SKPhysicsBody? {
        entity?.component(ofType: PhysicsComponent.self)?.body
    }
}
