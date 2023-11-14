//
//  ContentView.swift
//  TagGame
//
//  Created by Geovana Contine on 13/11/23.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    
    private var gameScene: SKScene {
        let scene = SKScene(fileNamed: "GameScene")!
        scene.scaleMode = .aspectFit
        return scene
    }
    
    private var debugOptions: SpriteView.DebugOptions {
        [.showsFPS, .showsNodeCount]
    }
    
    var body: some View {
        SpriteView(scene: gameScene, debugOptions: debugOptions)
    }
}

#Preview {
    ContentView()
}
