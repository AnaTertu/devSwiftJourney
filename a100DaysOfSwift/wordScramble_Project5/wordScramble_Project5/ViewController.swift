import UIKit

class ViewController: UITableViewController {
    
    var allWords = [String]()
    var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reiniciar", style: .plain, target: self, action: #selector(restartGame))
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
           if let startWords = try? String(contentsOf: startWordsURL, encoding: .utf8) {
               allWords = startWords.components(separatedBy: "\n")
           }
       }
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL, encoding: .utf8) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["amora"]
        }
        
        startGame()
    }

    func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return usedWords.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        
        return cell
    }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Submit", style: .default) {
             [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }

        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    @objc func restartGame() {
        startGame()
    }
    
    func showErrorMessage(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func submit(_ answer: String) {
        
        guard answer.count > 1 else {
            let ac = UIAlertController(title: "Palavra muito curta | Very short word", message: "Digite uma palavra com pelo menos 2 letras.  Enter a word with at least 2 letters.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
            return
        }
        
        guard let baseWord = title?.lowercased() else { return }
        let lowerAnswer = answer.lowercased()
        
        guard lowerAnswer != baseWord else {
            let ac = UIAlertController(title: "Palavra inválida", message: "Você não pode usar a palavra base!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
            return
        }

        
        
        // let errorTitle: String
        // let errorMessage: String
        
        
        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    usedWords.insert(answer, at: 0)

                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)

                    return
                } else {
                    //errorTitle = "Palavra não reconhecida | Word not recognised" ...
                    //errorMessage = "Você não pode simplesmente inventá-las, sabia! | You can't just make them up, you know!" ...
                    showErrorMessage(
                        title: "Palavra não reconhecida | Word not recognised",
                        message: "Você não pode simplesmente inventá-las, sabia! | You can't just make them up, you know!"
                    )
                }
            } else {
                showErrorMessage(
                    title: "Palavra já usada | Word used already",
                    message: "Seja mais original! | Be more original!"
                )
            }
        } else {
            guard let title = title?.lowercased() else { return }
                showErrorMessage(
                    title: "Palavra impossível | Word not possible",
                    message: "Você não consegue soletrar essa palavra de *\(title)* | You can't spell that word from *\(title)*"
                )
        }
/*
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)*/
    }
    
    func isPossible(word: String) -> Bool {
        
        guard var tempWord = title?.lowercased() else { return false }

            for letter in word {
                if let position = tempWord.firstIndex(of: letter) {
                    tempWord.remove(at: position)
                } else {
                    return false
                }
            }

        return true
    }
    
    func isOriginal(word: String) -> Bool {
        
        return !usedWords.contains { $0.lowercased() == word.lowercased() }
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "pt-BR")

        return misspelledRange.location == NSNotFound
    }
    
}

