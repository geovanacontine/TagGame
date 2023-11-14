import GameplayKit

final class PlayerEntity: GKEntity {
    
    let id: String
    
    init(
        id: String,
        name: String,
        role: Role,
        skin: PlayerSkin,
        position: CGPoint
    ) {
        self.id = id
        super.init()
        
        let render = RenderComponent(size: .init(width: 16, height: 32))
        render.node.position = position
        addComponent(render)
        
        let orientation = OrientationComponent()
        addComponent(orientation)
        
        let physics = PhysicsComponent(body: physicsBody)
        addComponent(physics)
        
        let contact = ContactComponent(shouldContactWith: .player)
        addComponent(contact)
        
        let movement = MovementComponent(maxSpeed: 150)
        addComponent(movement)
        
        let animation = AnimationComponent(skin: skin)
        addComponent(animation)
        
        let role = RoleComponent(role: role)
        addComponent(role)
        
        let name = NameComponent(name: name)
        addComponent(name)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var physicsBody: SKPhysicsBody {
        let body = SKPhysicsBody(rectangleOf: .init(width: 16, height: 22), center: .init(x: 0, y: -5))
        body.affectedByGravity = false
        body.isDynamic = true
        body.allowsRotation = false
        body.categoryBitMask = PhysicsCategory.player.rawValue
        body.collisionBitMask = PhysicsCategory.wall.rawValue | PhysicsCategory.player.rawValue
        return body
    }
}
