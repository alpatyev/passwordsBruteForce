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
        button.addDefaultBorders()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var startStopButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play.circle"), for: .normal)
        button.tintColor = .black
        button.clipsToBounds = false
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
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
        indicator.color = .black
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    private lazy var processStatusLabel: UILabel = {
        let label = UILabel()
        label.addDefaultBorders()
        label.textAlignment = .center
        label.textColor = Constants.Colors.green
        label.backgroundColor = Constants.Colors.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        view.addSubview(processStatusLabel)
        view.addSubview(startStopButton)
        view.addSubview(passwordTextField)
        view.addSubview(processIndicator)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            processConsoleLabel.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.centerYAnchor,
                                                     constant: -Constants.Layout.defaultSpacing * 3),
         
            processConsoleLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,
                                                      constant: Constants.Layout.defaultSpacing),
            processConsoleLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,
                                                       constant: -Constants.Layout.defaultSpacing),
            processConsoleLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            processStatusLabel.heightAnchor.constraint(equalToConstant: Constants.Layout.defaultSpacing * 2),
            processStatusLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,
                                                     constant: Constants.Layout.defaultSpacing),
            processStatusLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,
                                                       constant: -Constants.Layout.defaultSpacing),
            processStatusLabel.bottomAnchor.constraint(equalTo: processConsoleLabel.topAnchor,
                                                       constant: -Constants.Layout.defaultSpacing / 2)
        ])
        
        NSLayoutConstraint.activate([
            startStopButton.heightAnchor.constraint(equalToConstant: Constants.Layout.defaultSpacing * 3),
            startStopButton.widthAnchor.constraint(equalToConstant: Constants.Layout.defaultSpacing * 3),
            startStopButton.leftAnchor.constraint(equalTo: processStatusLabel.leftAnchor),
            startStopButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.frame.height / 4)
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.heightAnchor.constraint(equalTo: startStopButton.heightAnchor),
            passwordTextField.leftAnchor.constraint(equalTo: startStopButton.rightAnchor,
                                                    constant: Constants.Layout.defaultSpacing),
            passwordTextField.rightAnchor.constraint(equalTo: processIndicator.leftAnchor,
                                                     constant: -Constants.Layout.defaultSpacing),
            passwordTextField.centerYAnchor.constraint(equalTo: startStopButton.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            processIndicator.heightAnchor.constraint(equalTo: startStopButton.heightAnchor),
            processIndicator.widthAnchor.constraint(equalTo: startStopButton.widthAnchor),
            processIndicator.rightAnchor.constraint(equalTo: processStatusLabel.rightAnchor),
            processIndicator.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor)
        ])
    }
    
    // MARK: - Actions

    var animatingornot = false {
        didSet {
            if animatingornot == true {
                startStopButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
                processIndicator.startAnimating()

            } else {
                startStopButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
                processIndicator.stopAnimating()
            }
        }
    }
    
    @objc private func tapped() {
        animatingornot.toggle()
    }
    
}

