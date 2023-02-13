import Foundation

// MARK: - Presenter protocol

protocol BasePresenterProtocol: AnyObject {
    var delegate: BaseViewProtocol? { get set }
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
    

}

