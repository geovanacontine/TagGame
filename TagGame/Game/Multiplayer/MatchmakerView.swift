import SwiftUI
import GameKit

struct MatchmakerView {
    weak var delegate: GKMatchmakerViewControllerDelegate?
    let request: GKMatchRequest
}

extension MatchmakerView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> GKMatchmakerViewController {
        let view = GKMatchmakerViewController(matchRequest: request)!
        view.matchmakerDelegate = delegate
        return view
    }
    
    func updateUIViewController(_ uiViewController: GKMatchmakerViewController, context: Context) {}
}
