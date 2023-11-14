import GameplayKit

final class FreezeComponent: GKComponent {
    
    private(set) var isFrozen = false
    
    override func didAddToEntity() {
        renderNode?.removeAllActions()
        isFrozen = true
        body?.isDynamic = false
        renderNode?.shader = Resources.loadShader(ofType: .freeze)
    }
    
    override func willRemoveFromEntity() {
        isFrozen = false
        body?.isDynamic = true
        renderNode?.shader = nil
    }
}

// MARK: - API

extension FreezeComponent {
    private var renderNode: SKSpriteNode? {
        entity?.component(ofType: RenderComponent.self)?.node
    }
    
    private var body: SKPhysicsBody? {
        entity?.component(ofType: PhysicsComponent.self)?.body
    }
}
