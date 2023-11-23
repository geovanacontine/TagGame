import SwiftUI
import SpriteKit

struct ContentView: View {
    
    @StateObject var manager = GameCenterManager()
    
    private var gameScene: SKScene {
        let scene = SKScene(fileNamed: "GameScene")!
        scene.scaleMode = .aspectFit
        return scene
    }
    
    private var debugOptions: SpriteView.DebugOptions {
        [.showsFPS, .showsNodeCount]
    }
    
    var body: some View {
        ZStack {
            if !manager.isAuthenticated {
                Text("Not authenticated")
                    .task { manager.authenticateUser() }
            }
            
            if manager.isAuthenticated {
                Button("Open Matchmaking") {
                    manager.showMatchmaker()
                }
            }
            
            if manager.isShowingMatchmaker {
                MatchmakerView(delegate: manager, request: manager.request)
                    .ignoresSafeArea()
            }
            
            if manager.isMatchReady {
                SpriteView(scene: gameScene, debugOptions: debugOptions)
            }
        }
    }
}

#Preview {
    ContentView()
}
