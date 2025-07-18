import UIKit

class ViewController: UIViewController {
    
    var cluesLabel: UILabel!
    var answersLabel: UILabel!
    var currentAnswer: UITextField!
    var scoreLabel: UILabel!
    var letterButtons = [UIButton]()
    
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var level = 1
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemGray6

        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        
        cluesLabel = UILabel()
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        if let customFont = UIFont(name: "Chalkboard SE", size: 30) {
            cluesLabel.font = customFont
        } else {
            cluesLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        }
        cluesLabel.text = "CLUES"
        cluesLabel.numberOfLines = 0
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        cluesLabel.backgroundColor = .systemGray5
        cluesLabel.layer.cornerRadius = 10
        view.addSubview(cluesLabel)
        
        answersLabel = UILabel()
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        if let customFont = UIFont(name: "Avenir Next", size: 30) {
            answersLabel.font = customFont
        } else {
            answersLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        }
        answersLabel.text = "Answers"
        answersLabel.numberOfLines = 0
        answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        answersLabel.backgroundColor = .systemGray3
        answersLabel.textColor = .blue
        view.addSubview(answersLabel)
        
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Toque nas letras para adivinhar" //Tap letters to guess
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: 44)
        currentAnswer.isUserInteractionEnabled = false
        view.addSubview(currentAnswer)
        
        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("Submit", for: .normal)
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        view.addSubview(submit)
        
        let clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("Clear", for: .normal)
        clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        view.addSubview(clear)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.layer.cornerRadius = 25
        buttonsView.backgroundColor = .purple
        view.addSubview(buttonsView)
    
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
            cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.7, constant: -100),
            
            answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
            answersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.3, constant: -100),
            answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
            
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20),
            
            submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            submit.heightAnchor.constraint(equalToConstant: 44),
            
            clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),
            clear.heightAnchor.constraint(equalToConstant: 44),
            
            buttonsView.widthAnchor.constraint(equalToConstant: 750),
            buttonsView.heightAnchor.constraint(equalToConstant: 320),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
        ])
        
        // Defina alguns valores para a largura e altura de cada botão
        let width = 150
        let height = 80
        
        // Crie 20 botões como uma grade 4x5
        for row in 0..<4 {
            for column in 0..<5 {
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36) //, weight: .bold)
                letterButton.setTitleColor(.white, for: .normal)
                letterButton.backgroundColor = .systemIndigo
                letterButton.layer.cornerRadius = 25
                letterButton.setTitle("WWW", for: .normal) // temporário
                
                // Calcule a moldura deste botão usando suas colunas e linhas
                let frame = CGRect(x: column * width, y: row * height, width: width, height: height)
                letterButton.frame = frame
                
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
                letterButton.addTarget(self, action: #selector(letterTapped(_:)), for: .touchUpInside) //(letterTapped), for: .touchUpInside)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let maskPath = UIBezierPath(
            roundedRect: cluesLabel.bounds,
            byRoundingCorners: [.topLeft, .bottomLeft],
            cornerRadii: CGSize(width: 25, height: 25)
        )

        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        cluesLabel.layer.mask = maskLayer
        
        let maskPath2 = UIBezierPath(
            roundedRect: answersLabel.bounds,
            byRoundingCorners: [.topRight, .bottomRight],
            cornerRadii: CGSize(width: 25, height: 25)
        )

        let maskLayer2 = CAShapeLayer()
        maskLayer2.path = maskPath2.cgPath
        answersLabel.layer.mask = maskLayer2
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        loadLevel()
    }
    
    func setLineSpacing(label: UILabel, spacing: CGFloat) {
        guard let labelText = label.text else { return }
        let attributedString = NSMutableAttributedString(string: labelText)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        label.attributedText = attributedString
    }
    
    @objc func letterTapped(_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else { return }
        
        currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
        activatedButtons.append(sender)
        sender.isHidden = true
    }
    
    @objc func submitTapped(_ sender: UIButton) {
        guard let answerText = currentAnswer.text else { return }
        
        if let solutionPosition = solutions.firstIndex(of: answerText) {
            activatedButtons.removeAll()
            
            var splitAnswers = answersLabel.text?.components(separatedBy: "\n")
            splitAnswers?[solutionPosition] = answerText
            answersLabel.text = splitAnswers?.joined(separator: "\n")
            
            currentAnswer.text = ""
            score += 1
            scoreLabel.text = "Score: \(score)"
            
            if score == solutions.count { //% 7 == 0 {
                let ac = UIAlertController(title: "Bom Trabalho!", message: "Você está pronto para o próximo nível?", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: levelUp))
                present(ac, animated: true)
            }
        } else {
            let ac = UIAlertController(title: "Palavra incorreta", message: "Tente novamente", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                self?.clearTapped(UIButton())
            })
            present(ac, animated: true)
        }
    }
    
    func levelUp(action: UIAlertAction) {
        
        score = 0
        level += 1
        
        solutions.removeAll(keepingCapacity: true)
        loadLevel()
        
        for button in letterButtons {
            button.isHidden = false
        }
    }
    
    @objc func clearTapped(_ sender: UIButton) {
        currentAnswer.text = ""
        
        for button in activatedButtons {
            button.isHidden = false
        }
        
        activatedButtons.removeAll()
    }
    
    func loadLevel() {
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        
        if let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt") {
            
            if let levelContents = try? String(contentsOf: levelFileURL, encoding: .utf8) {
                
                var lines = levelContents.components(separatedBy: .newlines).filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
                lines.shuffle()
                
                for (index, line) in lines.enumerated() {
                    let parts = line.components(separatedBy: ": ")
                    guard parts.count == 2 else {
                        print("Linha mal formatada: \(line)")
                        continue
                    }
                    
                    let answer = parts[0]
                    let clue = parts[1]
                    
                    clueString += "\(index + 1). \(clue)\n"
                    // t\(solutionWord.count)  letters\n"
                    
                    let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                    solutionString += "\(solutionWord.count)  letters\n"
                    solutions.append(solutionWord)
                    
                    let bits = answer.components(separatedBy: "|")
                    letterBits += bits
                }
                
                cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
                setLineSpacing(label: cluesLabel, spacing: 12)
                answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
                setLineSpacing(label: answersLabel, spacing: 12)
                
                /*
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.tabStops = [
                    NSTextTab(textAlignment: .right, location: 300, options: [:])
                ]
                paragraphStyle.defaultTabInterval = 300
                paragraphStyle.alignment = .left
                paragraphStyle.lineSpacing = 16
                
                let formattedClues = clueString
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                    .replacingOccurrences(of: "\n", with: "\n")
                    .replacingOccurrences(of: ": ", with: "\t")
               
                let attributedClues = NSAttributedString(
                    string: formattedClues,
                    attributes: [
                        .paragraphStyle: paragraphStyle,
                        .font: UIFont(name: "Menlo", size: 22) ?? UIFont.systemFont(ofSize: 22),
                    ]
                )
                
                cluesLabel.attributedText = attributedClues
                
                let formattedAnswers = solutionString
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                
                let attributedAnswers = NSAttributedString(
                    string: formattedAnswers,
                    attributes: [
                        .paragraphStyle: paragraphStyle,
                        .font: UIFont(name: "Menlo", size: 22) ?? UIFont.systemFont(ofSize: 22),
                        .foregroundColor: UIColor.blue
                    ]
                )
                
                answersLabel.attributedText = attributedAnswers
                */
                
                letterButtons.shuffle()
                
                if letterButtons.count == letterBits.count {
                    for i in 0..<letterButtons.count {
                        letterButtons[i].setTitle(letterBits[i], for: .normal)
                    }
                }
            }
        }
    }
}
