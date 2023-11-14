import GameplayKit

final class PhysicsComponent: GKComponent {
    
    let body: SKPhysicsBody
    
    init(body: SKPhysicsBody) {
        self.body = body
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didAddToEntity() {
        entity?.component(ofType: RenderComponent.self)?.node.physicsBody = body
    }
    
    override func willRemoveFromEntity() {
        entity?.component(ofType: RenderComponent.self)?.node.physicsBody = nil
    }
}
