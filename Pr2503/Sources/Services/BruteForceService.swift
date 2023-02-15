import Foundation

// MARK: - Brute force delegate

protocol BruteForceProtocol {
    var delegate: BruteForce? { get set }
    
    func startRunning()
    func pauseRunning()
    func resetRunning(with new: String)
}

// MARK: - Brute force class

final class BruteForceService: BruteForceProtocol {
   
    // MARK: - Main values
    
    private var expectedPassword = ""
    private var generatedPassword = ""
    private let allowedSymbols: [String] = String().printable.map { String($0) }
    private var isRunning = false
  
    // MARK: - Delegate
    
    var delegate: BruteForce?
    
    // MARK: - Input methods
    
    func startRunning() {
        isRunning = true
        if !expectedPassword.isEmpty {
            DispatchQueue.global(qos: .utility).async {
                self.startCracking()
            }
        }
    }
    
    func pauseRunning() {
        isRunning = false
    }
        
    func resetRunning(with new: String) {
        pauseRunning()
        
        guard new != "" else {
            return
        }
        expectedPassword = new
        
        if new.count == 0 {
            print("EMPTY PASSWORD")
            delegate?.emptyPassword()
            generatedPassword = expectedPassword
        } else {
            generatedPassword = String(repeating: allowedSymbols.first ?? "0",
                                       count: new.count)
        }
        print("UPDATED: '\(generatedPassword)' : '\(expectedPassword)'")
        
    }
    
    // MARK: - Legacy logic below ~
    
    func startCracking() {
        var counter = 0
        print("push to start", isRunning)
        
        if generatedPassword == expectedPassword {
            delegate?.successfullyCracked(with: generatedPassword)
            generatedPassword = ""
            expectedPassword = ""
        }
        
        while isRunning {
            counter += 1
            generatedPassword = generateBruteForce(generatedPassword, fromArray: allowedSymbols)
            if generatedPassword == expectedPassword {
                delegate?.successfullyCracked(with: generatedPassword)
                generatedPassword = ""
                expectedPassword = ""
                break
            }
            if counter == 100 {
                counter = 0
                delegate?.shareLog(with: generatedPassword)
            }
        }
        generatedPassword = ""
        expectedPassword = ""
    }
    
    func indexOf(character: Character, _ array: [String]) -> Int {
        return array.firstIndex(of: String(character))!
    }

    func characterAt(index: Int, _ array: [String]) -> Character {
        return index < array.count ? Character(array[index]) : Character("")
    }

    func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
        var password: String = string

        if password.count <= 0 {
            password.append(characterAt(index: 0, array))
        }
        else {
            password.replace(at: password.count - 1,
                        with: characterAt(index: (indexOf(character: password.last!, array) + 1) % array.count, array))

            if indexOf(character: password.last!, array) == 0 {
                password = String(generateBruteForce(String(password.dropLast()), fromArray: array)) + String(password.last!)
            }
        }
        return password
    }
}
