import GameplayKit

final class AnimationComponent: GKComponent {
    
    private let skin: PlayerSkin
    private let defaultTimePerFrame: TimeInterval = 0.1
    private var currentAnimationOrientation: Orientation = .up
    private var currentAnimationState: MovementState = .idle
    
    init(skin: PlayerSkin) {
        self.skin = skin
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        if shouldChangeAnimation {
            runAnimation()
        }
    }
}

// MARK: - API

extension AnimationComponent {
    private var shouldChangeAnimation: Bool {
        didChangeState || didChangeOrientation
    }
    
    private var didChangeOrientation: Bool {
        nodeOrientation != currentAnimationOrientation
    }
    
    private var didChangeState: Bool {
        movementState != currentAnimationState
    }
    
    private func runAnimation() {
        animateForever(textures: texturesToAnimate)
        currentAnimationState = movementState
        currentAnimationOrientation = nodeOrientation
    }
    
    private func animateForever(textures: [SKTexture]) {
        renderNode?.run(.repeatForever(.animate(with: textures, timePerFrame: defaultTimePerFrame)))
    }
    
    private var texturesToAnimate: [SKTexture] {
        Resources.load(forSkin: skin, andState: movementState, withOrientation: nodeOrientation)
    }
    
    private var renderNode: SKNode? {
        entity?.component(ofType: RenderComponent.self)?.node
    }
    
    private var nodeOrientation: Orientation {
        entity?.component(ofType: OrientationComponent.self)?.orientation ?? .down
    }
    
    private var movementState: MovementState {
        entity?.component(ofType: MovementComponent.self)?.state ?? .idle
    }
}
