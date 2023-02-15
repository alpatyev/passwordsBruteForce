import UIKit

// MARK: - View protocol

protocol BaseViewProtocol: UIViewController {
    var presenter: BasePresenterProtocol? { get set }
    
    func turnLightMode()
    func turnDarkMode()
    
    func showControls()
    func hideControls()
    func controlsImage(named: String)
    
    func startAnimation()
    func endAnimation()
    
    func hideKeyboard()
    func showAlert(with text: String)
    
    func showPassword()
    func hidePassword()
    
    func updateButton(with text: String)
    func updateConsole(with text: String)
    
    func lockTextField()
    func unlockTextfield()
    func correctTextField(with text: String)
    func checkEmptyTextField() -> Bool
}

// MARK: - View class

final class BaseViewController: UIViewController, BaseViewProtocol {

    // MARK: - Prenter
    
    var presenter: BasePresenterProtocol?
    
    // MARK: - UI
    
    private lazy var rainingCodeBackground: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rainingCode")
        imageView.layer.opacity = 0.5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var dayNightButton: UIButton = {
        let button = UIButton()
        button.tintColor = Constants.Colors.black
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(dayNightTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var startPauseButton: UIButton = {
        let button = UIButton()
        button.tintColor = Constants.Colors.black
        button.clipsToBounds = false
        button.isHidden = true
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(startPauseTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.addDefaultBorders()
        textField.delegate = self
        textField.isSecureTextEntry = true
        textField.textAlignment = .center
        textField.keyboardType = .asciiCapable
        textField.font = .monospacedDigitSystemFont(ofSize: 28,
                                                    weight: .regular)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var processIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    
    private lazy var processControlButton: UIButton = {
        let button = UIButton()
        button.addDefaultBorders()
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(Constants.Colors.green, for: .normal)
        button.backgroundColor = Constants.Colors.black
        button.addTarget(self, action: #selector(processControlTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var processConsoleLabel: UITextView = {
        let textView = UITextView()
        textView.addDefaultBorders()
        textView.isEditable = false
        textView.isSelectable = false
        textView.isUserInteractionEnabled = false
        textView.textAlignment = .center
        textView.font = .monospacedDigitSystemFont(ofSize: 20,
                                                   weight: .regular)
        textView.textColor = Constants.Colors.green
        textView.backgroundColor = Constants.Colors.black
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Configure with and presenter
    
    public func configure(with presenter: BasePresenterProtocol?) {
        self.presenter = presenter
    }
    
    // MARK: - Setups

    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupHierarchy() {
        view.addSubview(rainingCodeBackground)
        view.addSubview(processConsoleLabel)
        view.addSubview(processControlButton)
        view.addSubview(startPauseButton)
        view.addSubview(passwordTextField)
        view.addSubview(processIndicator)
        view.addSubview(dayNightButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            rainingCodeBackground.topAnchor.constraint(equalTo: view.topAnchor),
            rainingCodeBackground.leftAnchor.constraint(equalTo: view.leftAnchor),
            rainingCodeBackground.rightAnchor.constraint(equalTo: view.rightAnchor),
            rainingCodeBackground.bottomAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            dayNightButton.heightAnchor.constraint(equalToConstant: Constants.Layout.defaultSpacing * 2),
            dayNightButton.widthAnchor.constraint(equalToConstant: Constants.Layout.defaultSpacing * 2),
            dayNightButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,
                                                  constant: -Constants.Layout.defaultSpacing),
            dayNightButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            startPauseButton.heightAnchor.constraint(equalToConstant: Constants.Layout.defaultSpacing * 2),
            startPauseButton.widthAnchor.constraint(equalToConstant: Constants.Layout.defaultSpacing * 2),
            startPauseButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,
                                                   constant: Constants.Layout.defaultSpacing),
            startPauseButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.frame.height / 4)
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.heightAnchor.constraint(equalTo: startPauseButton.heightAnchor),
            passwordTextField.leftAnchor.constraint(equalTo: startPauseButton.rightAnchor,
                                                    constant: Constants.Layout.defaultSpacing),
            passwordTextField.rightAnchor.constraint(equalTo: dayNightButton.rightAnchor,
                                                     constant: -Constants.Layout.defaultSpacing * 3),
            passwordTextField.centerYAnchor.constraint(equalTo: startPauseButton.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            processIndicator.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            processIndicator.centerXAnchor.constraint(equalTo: dayNightButton.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            processControlButton.topAnchor.constraint(equalTo: startPauseButton.bottomAnchor,
                                                  constant: Constants.Layout.defaultSpacing * 2),
            processControlButton.heightAnchor.constraint(equalToConstant: Constants.Layout.defaultSpacing * 2),
            processControlButton.leftAnchor.constraint(equalTo: startPauseButton.leftAnchor),
            processControlButton.rightAnchor.constraint(equalTo: dayNightButton.rightAnchor),
        ])
        
        NSLayoutConstraint.activate([
            processConsoleLabel.topAnchor.constraint(greaterThanOrEqualTo: processControlButton.bottomAnchor,
                                                     constant: Constants.Layout.defaultSpacing),
            processConsoleLabel.leftAnchor.constraint(equalTo: startPauseButton.leftAnchor),
            processConsoleLabel.rightAnchor.constraint(equalTo: dayNightButton.rightAnchor),
            processConsoleLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Presenter delegate methods
    
    func turnLightMode() {
        startPauseButton.tintColor = Constants.Colors.black
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "password",
                                                                     attributes: [NSAttributedString.Key.foregroundColor : Constants.Colors.black])
        
        dayNightButton.tintColor = Constants.Colors.black
        dayNightButton.setImage(UIImage(systemName: "sun.max"), for: .normal)
        
        overrideUserInterfaceStyle = .light
        setNeedsStatusBarAppearanceUpdate()
        view.backgroundColor = Constants.Colors.white
    }
    
    func turnDarkMode() {
        startPauseButton.tintColor = Constants.Colors.white
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "password",
                                                                     attributes: [NSAttributedString.Key.foregroundColor : Constants.Colors.white])
        
        dayNightButton.tintColor = Constants.Colors.white
        dayNightButton.setImage(UIImage(systemName: "moon"), for: .normal)
        
        overrideUserInterfaceStyle = .dark
        setNeedsStatusBarAppearanceUpdate()
        view.backgroundColor = Constants.Colors.black
    }
    
    func showControls() {
        startPauseButton.isHidden = false
    }
    
    func hideControls() {
        startPauseButton.isHidden = true
    }
    
    func controlsImage(named: String) {
        startPauseButton.setImage(UIImage(systemName: named), for: .normal)
    }
    
    func startAnimation() {
        processIndicator.startAnimating()
    }
    
    func endAnimation() {
        processIndicator.stopAnimating()
    }
    
    func hideKeyboard() {
        passwordTextField.resignFirstResponder()
    }
    
    func showPassword() {
        passwordTextField.isSecureTextEntry = false
    }
    
    func hidePassword() {
        passwordTextField.isSecureTextEntry = true
    }
    
    func showAlert(with text: String) {
        let alert = UIAlertController(title: "Warning!",
                                      message: text,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .cancel))
        self.present(alert, animated: false, completion: nil)
    }
    
    func updateButton(with text: String) {
        processControlButton.setTitle(text, for: .normal)
    }
    
    func updateConsole(with text: String) {
        processConsoleLabel.text = text
    }
    
    func lockTextField() {
        passwordTextField.isUserInteractionEnabled = false
    }
    
    func unlockTextfield() {
        passwordTextField.isUserInteractionEnabled = true
    }
    
    func correctTextField(with text: String) {
        passwordTextField.text = text
    }
    
    func checkEmptyTextField() -> Bool {
        passwordTextField.text == nil ? true : false
    }
    
    // MARK: - View events
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, touch.view != passwordTextField {
            presenter?.tappedOverTextfield()
        }
    }
    
    @objc private func dayNightTapped() {
        presenter?.dayNightButton()
    }
        
    @objc private func startPauseTapped() {
        presenter?.startPauseButton()
    }
    
    @objc private func processControlTapped() {
        presenter?.processControlButton()
    }
}

extension BaseViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        presenter?.keyboardShowed(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        presenter?.keyboardShowed(false)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        presenter?.textFieldReturn(with: textField.text)
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        presenter?.textFieldChangePassword(with: textField.text)
    }
}
