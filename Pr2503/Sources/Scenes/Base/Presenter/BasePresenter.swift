import Foundation

// MARK: - Presenter protocol

protocol BasePresenterProtocol: AnyObject {
    var delegate: BaseViewProtocol? { get set }
    
    func tappedOverTextfield()
    func textFieldReturn(with text: String?)
    func textFieldOnScreen(is onScreen: Bool)
    func textFieldChangePassword(with text: String?)
    
    func dayNightButton()
    func startPauseButton()
    func processControlButton()
}

// MARK: - Presenter class

final class BasePresenter: BasePresenterProtocol {
    
    // MARK: - Model
    
    private var model = BaseModel()
    
    // MARK: - View
    
    weak var delegate: BaseViewProtocol?
    
    // MARK: - Configure with and view
    
    public func configure(with view: BaseViewProtocol?) {
        self.delegate = view
    }
    
    // MARK: - View send events
    
    func tappedOverTextfield() {
        print("close textfield")
    }
   
    func textFieldOnScreen(is onScreen: Bool) {
        if onScreen {
            print("ON SCREEN")
        } else {
            print("CLOSED")
        }

    }
    
    func textFieldReturn(with text: String?) {
        guard let password = text else {
            return
        }
        print(#function + " with \(password)")
    }
    
    func textFieldChangePassword(with text: String?) {
        guard let count = text?.count else {
            print("no count")
            return
        }
        print(count)
    }
    
    func dayNightButton() {
        print(#function)
    }
    
    func startPauseButton() {
        print(#function)
    }
    
    func processControlButton() {
        print(#function)
    }
}

