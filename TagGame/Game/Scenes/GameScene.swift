import SpriteKit

final class GameScene: SKScene {
    
    // Managers
    private var entityManager: EntityManager?
    private var inputManager: InputManager?
    
    // Players
    private var players: [PlayerEntity] = []
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        entityManager = EntityManager(scene: self)
        setupEntities()
        setupInputManager()
    }
    
    override func update(_ currentTime: TimeInterval) {
        entityManager?.update(currentTime)
    }
    
    private func setupInputManager() {
        guard let localPlayer = players.first else { return }
        inputManager = InputManager(player: localPlayer)
    }
    
    private func setupEntities() {
        let player1 = PlayerEntity(id: "1", name: "Xio", role: .catcher, skin: .amelia, position: .zero)
        let player2 = PlayerEntity(id: "2", name: "Geovana", role: .runner, skin: .adam, position: .init(x: 100, y: 100))
        let player3 = PlayerEntity(id: "3", name: "Contine", role: .runner, skin: .bob, position: .init(x: 50, y: 50))
        let player4 = PlayerEntity(id: "4", name: "123", role: .runner, skin: .alex, position: .init(x: -100, y: 0))
        
        entityManager?.addEntity(player1)
        entityManager?.addEntity(player2)
        entityManager?.addEntity(player3)
        entityManager?.addEntity(player4)
        players = [player1, player2, player3, player4]
    }
}

// MARK: - Physics

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        entityManager?.didBegin(contact)
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        entityManager?.didEnd(contact)
    }
}

// MARK: - Input

extension GameScene {
    override func keyDown(with event: NSEvent) {
        inputManager?.keyDown(with: event)
    }
}
