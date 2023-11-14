import GameplayKit

final class RenderComponent: GKComponent {
    
    let node: SKSpriteNode
    
    init(size: CGSize) {
        node = SKSpriteNode(color: .red, size: size)
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didAddToEntity() {
        node.entity = entity
    }
    
    override func willRemoveFromEntity() {
        node.removeFromParent()
    }
}

// MARK: - API

extension RenderComponent {
    func changeTexture(imageNamed: String) {
        node.texture = .init(imageNamed: imageNamed)
    }
}
