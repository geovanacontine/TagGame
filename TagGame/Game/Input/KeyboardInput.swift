import SpriteKit

enum KeyboardKey: uint16 {
    case a = 0
    case d = 2
    case s = 1
    case w = 13
    case arrowLeft = 123
    case arrowRight = 124
    case arrowUp = 126
    case arrowDown = 125
}

struct KeyboardInput {
    func keyDown(with event: NSEvent) -> Orientation? {
        switch KeyboardKey(rawValue: event.keyCode) {
        case .a, .arrowLeft: return .left
        case .d, .arrowRight: return .right
        case .s, .arrowDown: return .down
        case .w, .arrowUp: return .up
        default:
            return nil
        }
    }
}
