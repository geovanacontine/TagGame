import SpriteKit

struct InputManager {
    
    let device = KeyboardInput()
    let player: PlayerEntity
    
    func keyDown(with event: NSEvent) {
        guard let orientation = device.keyDown(with: event) else { return }
        player.component(ofType: MovementComponent.self)?.move(orientation: orientation)
    }
}
