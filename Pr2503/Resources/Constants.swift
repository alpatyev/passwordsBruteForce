import UIKit

enum Constants {
    enum Colors {
        static let red: UIColor = .systemRed
        static let green: UIColor = .systemGreen
        static let white: UIColor = .white
        static let black: UIColor = .black
        static let border = UIColor.gray.withAlphaComponent(0.5).cgColor
    }
    
    enum Layout {
        static let cornerRadius: CGFloat = 18
        static let borderWidth: CGFloat = 4
        static let thinBorderWidth: CGFloat = 2
        static let defaultSpacing: CGFloat = 20
    }
    
    enum Messages {
        enum Status {
            static let startNewProcess = "START NEW BRUTFORCE"
            static let working = "WORKING..."
            static let paused = "PAUSED"
        }
        
        enum Alerts {
            static let success = "Password guessed"
            static let reachedSymbolsLimit = "Password length cannot be more than 10 symbols."
            static let emptyPasswordError = "Password cannot be empty. You have to create password with length from 1 up to 10 symbols."
        }
    }
}
