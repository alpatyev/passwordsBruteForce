import Foundation
import FileProvider

// MARK: - Presenter-view protocol

protocol BasePresenterProtocol: AnyObject {
    var viewDelegate: BaseViewProtocol? { get set }
    
    func keyboardShowed(_ onScreen: Bool)
    
    func tappedOverTextfield()
    func textFieldReturn(with text: String?)
    func textFieldChangePassword(with text: String?)
    
    func dayNightButton()
    func startPauseButton()
    func processControlButton(with textField: String?)
}

// MARK: - Presenter-service protocol

protocol BruteForce {
   
}

// MARK: - Presenter class

final class BasePresenter: BasePresenterProtocol, BruteForce {

    // MARK: - Model
    
    private var model = BaseModel() {
        didSet {
            performKeyboardUpdates(compare: oldValue.isKeyboardShowed)
            performInterfaceUpdates(compare: oldValue.state)
        }
    }
    
    // MARK: - Delegates
    
    weak var viewDelegate: BaseViewProtocol?
    private var bruteForceDelegate: BruteForceProtocol?
    
    // MARK: - Configure with view
    
    public func configure(with view: BaseViewProtocol?, service: BruteForceProtocol?) {
        viewDelegate = view
        bruteForceDelegate = service
        bruteForceDelegate?.delegate = self
        
        performInterfaceUpdates(compare: .paused)
    }
    
    // delete after configuring
    
    private func modelConsoleLog() {
        print("> UPDATED STATE   : \(model.state)")
        print("- password        : \(model.recievedPassword)")
        print("- keyboard showed : \(model.isKeyboardShowed)")

        print("- control hidden  : \(model.isControlHidden)")

        print("- input enabled   : \(model.isTextFieldAccessible)")

        print("- now animating   : \(model.isAnimating)")
        print("- darkmode on     : \(model.isDarkMode)\n")
    }
        
    // MARK: - Private methods - update view with model, or just update view
    
    private func performInterfaceUpdates(compare oldState: BaseModel.Stage) {
        modelConsoleLog()
        
        performAppearance()
        
        if oldState != model.state {
            switch model.state {
                case .stopped:
                    performStoppedState()
                case .running:
                    performRunningState()
                case .paused:
                    performPausedState()
            }
        }
    }
    
    private func performAppearance() {
        model.isDarkMode ? viewDelegate?.turnDarkMode() : viewDelegate?.turnLightMode()
    }
    
    private func performKeyboardUpdates(compare oldValue: Bool) {
        if oldValue != model.isKeyboardShowed {
            if !model.isKeyboardShowed {
                viewDelegate?.hideKeyboard()
            }
        }
    }
        
    private func performStoppedState() {
        viewDelegate?.updateButton(with: Constants.Messages.Status.startNewProcess)
        viewDelegate?.unlockTextfield()
        viewDelegate?.hideControls()
        viewDelegate?.endAnimation()
    }
    
    private func performRunningState() {
        viewDelegate?.updateButton(with: Constants.Messages.Status.working)
        viewDelegate?.controlsImage(named: "pause.circle")
        viewDelegate?.showControls()
        viewDelegate?.startAnimation()
        viewDelegate?.lockTextField()
    }
    
    private func performPausedState() {
        viewDelegate?.updateButton(with: Constants.Messages.Status.paused)
        viewDelegate?.controlsImage(named: "play.circle")
        viewDelegate?.showControls()
        viewDelegate?.endAnimation()
        viewDelegate?.lockTextField()
    }
    
    private func presentAlert(_ message: String) {
        viewDelegate?.showAlert(with: message)
    }
    
 
    // MARK: - View send events
    
    func keyboardShowed(_ onScreen: Bool) {
        if model.isKeyboardShowed != onScreen {
            model.isKeyboardShowed = onScreen
        }
    }
    
    func tappedOverTextfield() {
        if model.isKeyboardShowed == true {
            model.isKeyboardShowed = false
        }
    }
   
    func textFieldReturn(with text: String?) {
        guard let password = text, text != "" else {
            presentAlert(Constants.Messages.Errors.emptyPasswordError)
            return
        }
        model.recievedPassword = password
        model.isKeyboardShowed = false
        model.state = .running
    }
    
    func textFieldChangePassword(with text: String?) {
        if let newPassword = text, newPassword.count < 11 {
            model.recievedPassword = newPassword
        } else {
            viewDelegate?.correctTextField(with: model.recievedPassword)
            presentAlert(Constants.Messages.Errors.reachedSymbolsLimit)
        }
    }
        
    func dayNightButton() {
        model.isDarkMode.toggle()
    }
    
    func startPauseButton() {
        if model.state == .running {
            model.state = .paused
        } else if model.state == .paused {
            model.state = .running
        }
    }
    
    func processControlButton(with textField: String?) {
        guard textField != nil, textField != "" else {
            presentAlert(Constants.Messages.Errors.emptyPasswordError)
            return
        }
        
        switch model.state {
            case .stopped:
                model.state = .running
            case .running:
                model.state = .stopped
            case .paused:
                model.state = .stopped
        }
    }
}
