import Foundation

// MARK: - Brute force delegate

protocol BruteForceProtocol {
    var delegate: BruteForce? { get set }
    
    func startRunning()
    func pauseRunning()
    func resetRunning()
}

// MARK: - Brute force class

final class BruteForceService: BruteForceProtocol {
   
    // MARK: - Main values
    
    private var expectedPassword = "qos"
    private var generatedPassword = ""
    private let allowedSymbols: [String] = String().printable.map { String($0) }
    private var isRunning = false
  
    // MARK: - Delegate
    
    var delegate: BruteForce?
    
    // MARK: - Input methods
    
    func startRunning() {
        isRunning = true
        DispatchQueue.global(qos: .utility).async {
            self.startshit()
        }
    }
    
    func pauseRunning() {
        isRunning = false
    }
        
    func resetRunning() {
        isRunning = false
    }

    
    // MARK: - Output methods
    
    
    // MARK: - Legacy logic below ~
    
    func startshit() {
        var counter = 0
        while isRunning && (generatedPassword.count < expectedPassword.count + 1) {
            counter += 1
            generatedPassword = generateBruteForce(generatedPassword, fromArray: allowedSymbols)
            if generatedPassword == expectedPassword {
                break
            }
            if counter == 100 {
                counter = 0
                delegate?.shareLog(with: generatedPassword)
            }
        }
        print("SUCESSS!")
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
