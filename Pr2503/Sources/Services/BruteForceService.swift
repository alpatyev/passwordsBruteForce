import Foundation

// MARK: - Brute force delegate

protocol BruteForceProtocol {
    var delegate: BruteForce? { get set }
    
    func run(with new: String)
    func pause()
    func reset()
}

// MARK: - Brute force class

final class BruteForceService: BruteForceProtocol {
    
    // MARK: - Delegate
    
    var delegate: BruteForce?
   
    // MARK: - Main values
    
    private var running = false
    private var generatedPassword = ""
    private var expectedPassword = ""
    private let allowedSymbols: [String] = String().printable.map { String($0) }
    
    // MARK: - GCD implementation
    
    private func executeGenerating() {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let pointer = self else { return }
            
            var counter = 0
            var log = String()
            
            while pointer.running {
                if pointer.generatedPassword == pointer.expectedPassword {
                    DispatchQueue.main.async {
                        log = "\n\(pointer.generatedPassword)" + log
                        if log.count > 60 {
                            pointer.delegate?.console(share: log)
                        }
                        pointer.delegate?.finished(with: pointer.generatedPassword)
                    }
                    break
                }
                
                if counter % 50 == 0 {
                    log = "\n\(pointer.generatedPassword)" + log
                }
                
                if counter == 1000 {
                    let copy = log
                    DispatchQueue.main.async {
                        if copy.count > 60 {
                            pointer.delegate?.console(share: copy)
                        }
                        counter = 0
                    }
                    log.removeAll()
                } else {
                    counter += 1
                }
                
                pointer.generatedPassword = pointer.generateBruteForce(pointer.generatedPassword, fromArray: pointer.allowedSymbols)
            }
        }
        
    }

    // MARK: - Input methods
    
    func run(with new: String) {
        if generatedPassword == "" {
            generatedPassword = String(repeating: "0", count: new.count)
        }
        
        print("* SERVICE   : RUNNING")
        running = true
        expectedPassword = new
        executeGenerating()
        
        
    }
    
    func pause() {
        running = false
        print("* SERVICE   : PAUSED")

    }
    
    func reset() {
        running = false
        print("* SERVICE   : RESET")
        generatedPassword = ""
        expectedPassword = ""
    }
            
    // MARK: - Legacy logic below ~
    
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
