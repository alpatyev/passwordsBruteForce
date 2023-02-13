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

    var button: UIButton!
    
    var isBlack: Bool = false {
        didSet {
            if isBlack {
                view.backgroundColor = .black
            } else {
                view.backgroundColor = .white
            }
        }
    }
    
    
    func onBut(_ sender: Any) {
        isBlack.toggle()
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Configure with and presenter
    
    public func configure(with presenter: BasePresenterProtocol?) {
        self.presenter = presenter
    }
    
    // MARK: - Setups

    private func setupView() {
        
    }
    
    private func setupHierarchy() {
        
    }
    
    private func setupLayout() {
        
    }
    
    // MARK: - Actions

    
}




