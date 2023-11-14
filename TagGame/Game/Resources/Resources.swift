import SpriteKit

struct Resources {
    static func load(
        forSkin skin: PlayerSkin,
        andState state: MovementState,
        withOrientation orientation: Orientation
    ) -> [SKTexture] {
        let namePrefix = skin.rawValue + "_" + state.rawValue + "_" + orientation.rawValue + "_"
        return generateTextureArray(namePrefix: namePrefix, frames: 6)
    }
    
    private static func generateTextureArray(namePrefix: String, frames: Int) -> [SKTexture] {
        let range = 1...frames
        return range.map({ SKTexture(imageNamed: namePrefix + "\($0)") })
    }
    
    static func loadShader(ofType shaderType: ShaderType) -> SKShader {
        SKShader(fileNamed: shaderType.rawValue)
    }
}
