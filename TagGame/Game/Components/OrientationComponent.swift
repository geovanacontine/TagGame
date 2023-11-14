import GameplayKit

final class OrientationComponent: GKComponent {
    
    private(set) var orientation: Orientation
    
    override init() {
        orientation = .down
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - API

extension OrientationComponent {
    func changeOrientation(to newOrientation: Orientation) {
        orientation = newOrientation
    }
}
