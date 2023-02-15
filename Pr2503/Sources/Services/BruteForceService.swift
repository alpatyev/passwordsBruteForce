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
    
    private let allowedSymbols: [String] = String().printable.map { String($0) }
    private var running = false
    private var generated = ""
    private var key = ""
    
    // MARK: - GCD implementation
    
    private func executeGenerating() {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let pointer = self else { return }
            
            var counter = 0
            var log = String()
            
            while pointer.running {
                if pointer.generated == pointer.key {
                    pointer.backToMainThread {
                        log = "\n\(pointer.generated)" + log
                        if log.count > 60 {
                            pointer.delegate?.console(share: log)
                        }
                        pointer.delegate?.finished(with: pointer.generated)
                    }
                    
                    break
                }
                
                if counter % 50 == 0 {
                    log = "\n\(pointer.generated)" + log
                }
                
                if counter == 1000 {
                    let copy = log
                    
                    pointer.backToMainThread {
                        if copy.count > 60 {
                            pointer.delegate?.console(share: copy)
                        }
                        counter = 0
                    }
                    
                    log.removeAll()
                } else {
                    counter += 1
                }
                
                pointer.generated = pointer.generateBruteForce(pointer.generated)
            }
        }
    }
    
    private func backToMainThread(_ completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            completion()
        }
    }
    
    // MARK: - Input methods
    
    func run(with new: String) {
        print("* SERVICE   : RUNNING\n")

        if generated == "" {
            generated = String(repeating: "0", count: new.count)
        }
        
        running = true
        key = new
        executeGenerating()
        
        
    }
    
    func pause() {
        running = false
        print("* SERVICE   : PAUSED\n")
    }
    
    func reset() {
        print("* SERVICE   : RESET\n")

        running = false
        generated = ""
        key = ""
    }
            
    // MARK: - Legacy logic below ~
    
    func indexOf(character: Character) -> Int {
        return allowedSymbols.firstIndex(of: String(character))!
    }

    func characterAt(index: Int) -> Character {
        return index < allowedSymbols.count ? Character(allowedSymbols[index]) : Character("")
    }

    func generateBruteForce(_ string: String) -> String {
        var password: String = string

        if password.count <= 0 {
            password.append(characterAt(index: 0))
        }
        else {
            password.replace(at: password.count - 1,
                             with: characterAt(index: (indexOf(character: password.last!) + 1) % allowedSymbols.count))

            if indexOf(character: password.last!) == 0 {
                password = String(generateBruteForce(String(password.dropLast())) + String(password.last!))
            }
        }
        return password
    }
}
