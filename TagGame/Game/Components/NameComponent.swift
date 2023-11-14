import GameplayKit

final class NameComponent: GKComponent {
    
    private let name: String
    private var labelNode: SKLabelNode?
    
    init(name: String) {
        self.name = name
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didAddToEntity() {
        addNameToEntity()
    }
    
    override func willRemoveFromEntity() {
        labelNode?.removeFromParent()
    }
}

// MARK: - API

extension NameComponent {
    private func addNameToEntity() {
        let newLabel = makeLabelNode()
        renderNode?.addChild(newLabel)
        labelNode = newLabel
        setupLabelColor()
    }
    
    private var renderNode: SKNode? {
        entity?.component(ofType: RenderComponent.self)?.node
    }
    
    private func makeLabelNode() -> SKLabelNode {
        let label = SKLabelNode(text: name)
        label.fontName = "HelveticaNeue-Bold"
        label.fontSize = 6
        label.position = .init(x: 0, y: 12)
        label.zPosition = 1
        return label
    }
    
    private func setupLabelColor() {
        guard let role = entity?.component(ofType: RoleComponent.self)?.role else { return }
        
        if role == .catcher {
            labelNode?.fontColor = .red
        }
    }
}
