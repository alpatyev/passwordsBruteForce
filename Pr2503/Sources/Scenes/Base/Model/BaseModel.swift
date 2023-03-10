
// MARK: - Model

struct BaseModel {
    enum Stage {
        case stopped
        case running
        case paused
    }
    
    var state: Stage = .stopped
    var recievedPassword = String()
    
    var isDarkMode = true
    var isKeyboardShowed = false
    
    var isAnimating: Bool {
        state == .running ? true : false
    }
    var isControlHidden: Bool {
        state == .stopped ? true : false
    }
    var isTextFieldAccessible: Bool {
        state == .stopped ? true : false
    }
}
