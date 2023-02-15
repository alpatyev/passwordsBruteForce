import Foundation

// MARK: - Brute force delegate

protocol BruteForceProtocol {
    var delegate: BruteForce? { get set }
}

// MARK: - Brute force class

final class BruteForceService: BruteForceProtocol {
   
    // MARK: - Main values
    
    private var generatedPassword = ""
    private let expectedPassword = ""
    private let allowedSymbols: [String] = String().printable.map { String($0) }
  
    // MARK: - Delegate
    
    var delegate: BruteForce?
    
    // MARK: - Input methods
    
    // MARK: - Legacy logic below ~
    
    func startCracking() {
        while generatedPassword.count == expectedPassword.count {
            print("GENERATED :   \(generatedPassword)")
            if generatedPassword == expectedPassword {
                print("CRACKED   : [ \(generatedPassword) ]")
                break
            }
            generatedPassword = generateBruteForce(generatedPassword, fromArray: allowedSymbols)
        }
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
