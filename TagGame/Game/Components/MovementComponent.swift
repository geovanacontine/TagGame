import GameplayKit

final class MovementComponent: GKComponent {
    
    private let maxSpeed: CGFloat
    private(set) var state: MovementState
    
    init(maxSpeed: CGFloat) {
        self.maxSpeed = maxSpeed
        state = .idle
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        if body?.velocity == .zero {
            state = .idle
        } else {
            state = .run
        }
    }
}

// MARK: - API

extension MovementComponent {
    func move(orientation: Orientation) {
        orientationComponent?.changeOrientation(to: orientation)
        body?.velocity = getVector(forOrientation: orientation)
    }
    
    private var body: SKPhysicsBody? {
        entity?.component(ofType: PhysicsComponent.self)?.body
    }
    
    private var orientationComponent: OrientationComponent? {
        entity?.component(ofType: OrientationComponent.self)
    }
    
    private func getVector(forOrientation orientation: Orientation) -> CGVector {
        switch orientation {
        case .up: .init(dx: 0, dy: maxSpeed)
        case .down: .init(dx: 0, dy: -maxSpeed)
        case .left: .init(dx: -maxSpeed, dy: 0)
        case .right: .init(dx: maxSpeed, dy: 0)
        }
    }
}
