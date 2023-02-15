import Foundation
import UIKit

// MARK: - Builder

final class SceneBuilder {
    static func createBaseScene() -> UIViewController {
        let bruteForce = BruteForceService()
        let presenter = BasePresenter()
        let view = BaseViewController()
        
        presenter.configure(with: view, service: bruteForce)
        view.configure(with: presenter)
        return view
    }
}

