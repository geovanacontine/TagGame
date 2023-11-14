import GameplayKit

final class EntityManager {
    
    private var scene: SKScene
    private var entities: [GKEntity] = []
    
    private var componentSystems: [GKComponentSystem] = [
        .init(componentClass: RenderComponent.self),
        .init(componentClass: AnimationComponent.self),
        .init(componentClass: OrientationComponent.self),
        .init(componentClass: MovementComponent.self),
        .init(componentClass: PhysicsComponent.self),
        .init(componentClass: ContactComponent.self),
        .init(componentClass: RoleComponent.self),
        .init(componentClass: FreezeComponent.self)
    ]
    
    init(scene: SKScene) {
        self.scene = scene
    }
    
    func addEntity(_ entity: GKEntity) {
        entities.append(entity)
        
        for componentSystem in componentSystems {
            componentSystem.addComponent(foundIn: entity)
        }
        
        if let renderComponent = entity.component(ofType: RenderComponent.self) {
            scene.addChild(renderComponent.node)
        }
    }
    
    func removeEntity(_ entity: GKEntity) {
        entity.components.forEach { $0.willRemoveFromEntity() }
        entities.removeAll(where: { $0 == entity })
        
        for componentSystem in componentSystems {
            componentSystem.removeComponent(foundIn: entity)
        }
    }
    
    func update(_ deltaTime: TimeInterval) {
        for componentSystem in componentSystems {
            componentSystem.update(deltaTime: deltaTime)
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let contactComponents = componentSystems.compactMap({ $0.components as? [ContactComponent] }).first else { return }
        
        for contactComponent in contactComponents {
            contactComponent.didBegin(contact)
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        guard let contactComponents = componentSystems.compactMap({ $0.components as? [ContactComponent] }).first else { return }
        
        for contactComponent in contactComponents {
            contactComponent.didEnd(contact)
        }
    }
}
