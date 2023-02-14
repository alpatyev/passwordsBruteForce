import UIKit

// MARK: - View protocol

protocol BaseViewProtocol: UIViewController {
    var presenter: BasePresenterProtocol? { get set }
}

// MARK: - View class

final class BaseViewController: UIViewController, BaseViewProtocol {
    
    // MARK: - Prenter
    
    var presenter: BasePresenterProtocol?
    
    // MARK: - UI
    
    private lazy var dayNightButton: UIButton = {
        let button = UIButton()
        button.tintColor = Constants.Colors.black
        //button.setImage(UIImage(systemName: "moon"), for: .highlighted)
        button.setImage(UIImage(systemName: "sun.max"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(dayNightTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var startPauseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play.circle"), for: .normal)
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
        textField.isSecureTextEntry = true
        textField.textAlignment = .center
        textField.placeholder = "password"
        textField.backgroundColor = Constants.Colors.white
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
    
    
    private lazy var resetStartButton: UIButton = {
        let button = UIButton()
        button.addDefaultBorders()
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(Constants.Colors.green, for: .normal)
        button.backgroundColor = Constants.Colors.black
        button.addTarget(self, action: #selector(resetStartTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var processConsoleLabel: UITextView = {
        let textView = UITextView()
        textView.addDefaultBorders()
        textView.text = "****"
        textView.isEditable = false
        textView.isSelectable = false
        textView.isScrollEnabled = true
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
        view.addSubview(processConsoleLabel)
        view.addSubview(resetStartButton)
        view.addSubview(startPauseButton)
        view.addSubview(passwordTextField)
        view.addSubview(processIndicator)
        view.addSubview(dayNightButton)
    }
    
    private func setupLayout() {
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
            processIndicator.rightAnchor.constraint(equalTo: dayNightButton.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            resetStartButton.topAnchor.constraint(equalTo: startPauseButton.bottomAnchor,
                                                  constant: Constants.Layout.defaultSpacing * 2),
            resetStartButton.heightAnchor.constraint(equalToConstant: Constants.Layout.defaultSpacing * 2),
            resetStartButton.leftAnchor.constraint(equalTo: startPauseButton.leftAnchor),
            resetStartButton.rightAnchor.constraint(equalTo: dayNightButton.rightAnchor),
        ])
        
        NSLayoutConstraint.activate([
            processConsoleLabel.topAnchor.constraint(greaterThanOrEqualTo: resetStartButton.bottomAnchor,
                                                     constant: Constants.Layout.defaultSpacing),
            processConsoleLabel.leftAnchor.constraint(equalTo: startPauseButton.leftAnchor),
            processConsoleLabel.rightAnchor.constraint(equalTo: dayNightButton.rightAnchor),
            processConsoleLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func dayNightTapped() {
        
    }
        
    @objc private func startPauseTapped() {
    }
    
    @objc private func resetStartTapped() {
    }
    
}

