import GameKit

final class GameCenterManager: NSObject, ObservableObject {
    
    @Published var isAuthenticated = false
    @Published var isShowingMatchmaker = false
    @Published var isMatchReady = false
    
    let request: GKMatchRequest = {
        let request = GKMatchRequest()
        request.minPlayers = 2
        request.maxPlayers = 2
        return request
    }()
    
    private let localPlayer = GKLocalPlayer.local
    private var match: GKMatch?
}

// MARK: - GKLocalPlayerListener

extension GameCenterManager: GKLocalPlayerListener {
    func showMatchmaker() {
        isShowingMatchmaker = true
    }
    
    func authenticateUser() {
        localPlayer.authenticateHandler = { [weak self] viewController, error in
            guard let self else { return }
            isAuthenticated = error == nil
            localPlayer.register(self)
        }
    }
}

// MARK: - GKMatchmakerViewControllerDelegate

extension GameCenterManager: GKMatchmakerViewControllerDelegate {
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFind match: GKMatch) {
        isShowingMatchmaker = false
        isMatchReady = true
        self.match = match
        self.match?.delegate = self
    }
    
    func matchmakerViewControllerWasCancelled(_ viewController: GKMatchmakerViewController) {
        isShowingMatchmaker = false
    }
    
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFailWithError error: Error) {
        isShowingMatchmaker = false
        print(error)
    }
}

// MARK: - GKMatchDelegate

extension GameCenterManager: GKMatchDelegate {}
