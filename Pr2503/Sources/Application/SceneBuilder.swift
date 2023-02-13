import Foundation
import UIKit

// MARK: - Builder

final class SceneBuilder {
    static func createBaseScene() -> UIViewController {
        //let model = BaseModel()
        //let presenter = BasePresenter()
        let view = BaseViewController()
        // DI
        return view
    }
}
