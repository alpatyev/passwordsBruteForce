import Foundation
import UIKit

// MARK: - Builder

final class SceneBuilder {
    static func createBaseScene() -> UIViewController {
        let presenter = BasePresenter()
        let view = BaseViewController()
        presenter.configure(with: view)
        view.configure(with: presenter)
        return view
    }
}

