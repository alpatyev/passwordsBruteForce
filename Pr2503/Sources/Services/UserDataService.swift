
import Foundation

// MARK: - UserDataService protocol

protocol UserDataServiceProtocol {
    func getData() -> BaseModel
    func updateData(with data: BaseModel)
}

// MARK: - UserDataService class

final class UserDataService: UserDataServiceProtocol {
    
    // MARK: - App data
    
    private var model: BaseModel {
        didSet {
            saveToUserDefaults()
        }
    }
    
    // MARK: - Coding keys
    
    private enum Keys {
        enum BaseModel: String {
            case state = "state"
            case password = "password"
            case darkmode = "darkmode"
            case keyboard = "keyboard"
        }
    }
    
    // MARK: - Lifecycle
    
    init() {
        model = BaseModel()
        model = loadFromUserDefauts()
    }
    
    // MARK: - Delegate methods
    
    func getData() -> BaseModel {
        model
    }
    
    func updateData(with data: BaseModel) {
        model = data
    }
    
    // MARK: - Internal methods
    
    private func loadFromUserDefauts() -> BaseModel {
        var mock = BaseModel()
        
        if let state = UserDefaults.standard.object(forKey: Keys.BaseModel.state.rawValue) as? BaseModel.Stage {
            mock.state = state
        }
        
        if let password = UserDefaults.standard.string(forKey: Keys.BaseModel.password.rawValue) {
            mock.recievedPassword = password
        }
        
        
        mock.isDarkMode = UserDefaults.standard.bool(forKey: Keys.BaseModel.darkmode.rawValue)
        
        mock.isKeyboardShowed = UserDefaults.standard.bool(forKey: Keys.BaseModel.keyboard.rawValue)
        
        return mock
    }
    
    private func saveToUserDefaults() {
        UserDefaults.standard.set(model.state,
                                  forKey: Keys.BaseModel.state.rawValue)
        UserDefaults.standard.set(model.recievedPassword,
                                  forKey: Keys.BaseModel.password.rawValue)
        UserDefaults.standard.set(model.isDarkMode,
                                  forKey: Keys.BaseModel.darkmode.rawValue)
        UserDefaults.standard.set(model.isKeyboardShowed,
                                  forKey: Keys.BaseModel.keyboard.rawValue)
    }
}
