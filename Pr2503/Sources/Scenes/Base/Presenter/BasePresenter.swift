
// MARK: - Presenter-view protocol

protocol BasePresenterProtocol: AnyObject {
    var viewDelegate: BaseViewProtocol? { get set }
    
    func keyboardShowed(_ onScreen: Bool)
    
    func tappedOverTextfield()
    func textFieldReturn(with text: String?)
    func textFieldChangePassword(with text: String?)
    
    func dayNightButton()
    func startPauseButton()
    func processControlButton()
}

// MARK: - Presenter-service protocol

protocol BruteForce {
    
}

// MARK: - Presenter class

final class BasePresenter: BasePresenterProtocol, BruteForce {
    
    // MARK: - Model
    
    private var model = BaseModel() {
        didSet {
            performViewUpdates()
        }
    }
    
    // MARK: - Delegates
    
    weak var viewDelegate: BaseViewProtocol?
    private var bruteForceDelegate: BruteForceProtocol?
    
    
    // MARK: - View
    
    
    // MARK: - Configure with view
    
    public func configure(with view: BaseViewProtocol?, service: BruteForceProtocol) {
        viewDelegate = view
        bruteForceDelegate = service
        bruteForceDelegate?.delegate = self
        performViewUpdates()
    }
    
    // MARK: - Called when model has been updated
        
    private func performViewUpdates() {        
        model.isDarkMode ? viewDelegate?.turnDarkMode() : viewDelegate?.turnLightMode()
        model.isAnimating ? viewDelegate?.startAnimation() : viewDelegate?.endAnimation()
        
        if !model.isKeyboardShowed {
            viewDelegate?.hideKeyboard()
        }
        
        if model.state == .stopped {
            viewDelegate?.hideControls()
            viewDelegate?.unlockTextfield()
            viewDelegate?.updateButton(with: Constants.Messages.Status.startNewProcess)
        } else {
            var image = String()
            var status = String()
            
            if model.state == .paused {
                image = "play.circle"
                status = Constants.Messages.Status.paused
            } else {
                image = "pause.circle"
                status = Constants.Messages.Status.working
            }
            
            viewDelegate?.updateButton(with: status)
            viewDelegate?.controlsImage(named: image)
            viewDelegate?.showControls()
            viewDelegate?.lockTextField()
        }
    }
 
    // MARK: - View send events
    
    func keyboardShowed(_ onScreen: Bool) {
        model.isKeyboardShowed = onScreen
    }
    
    func tappedOverTextfield() {
        model.isKeyboardShowed = false
    }
   
    func textFieldReturn(with text: String?) {
        guard let password = text else {
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
            viewDelegate?.showAlert(with: Constants.Messages.Errors.reachedSymbolsLimit)
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
    
    func processControlButton() {
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
