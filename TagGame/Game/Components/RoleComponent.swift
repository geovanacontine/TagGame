import GameplayKit

final class RoleComponent: GKComponent {
    
    let role: Role
    
    init(role: Role) {
        self.role = role
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        updateCatcher()
        updateRelease()
    }
}

// MARK: - API

extension RoleComponent {
    private func updateCatcher() {
        guard didCatch else { return }
        let freeze = FreezeComponent()
        contactingEntity?.addComponent(freeze)
    }
    
    private func updateRelease() {
        guard didRelease else { return }
        contactingEntity?.removeComponent(ofType: FreezeComponent.self)
    }
    
    private var didCatch: Bool {
        role == .catcher && contactingEntityRole == .runner
    }
    
    private var didRelease: Bool {
        contactingEntity?.component(ofType: FreezeComponent.self)?.isFrozen == true &&
        role == .runner
    }
    
    private var contactingEntityRole: Role? {
        contactingEntity?.component(ofType: RoleComponent.self)?.role
    }
    
    private var contactingEntity: GKEntity? {
        entity?.component(ofType: ContactComponent.self)?.contactingEntity
    }
}
