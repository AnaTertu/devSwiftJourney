import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    var correctAnswer: UITextField!
    var solutions = [String]()
    
    // MARK: - Properties (UIElements)
    var cluesLabel: UILabel!
    var answersLabel: UILabel!
    var scoreLabel: UILabel!
    var levelLabel: UILabel!
    
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    
    
    var submitButton = UIButton(type: .system)
    var clearButton = UIButton(type: .system)
    var buttonsView = UIView()
    
    // MARK: - Properties (Game State)
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var level = 1 {
        didSet {
            levelLabel.text = "Level: \(level)"
        }
    }
    
    // MARK: - View Lifecycle
    override func loadView() {
        view = UIView()
        view.backgroundColor = .yellow
        
        setupViews()
        setupHierarchy()
        setupConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadLevel()
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
    
    
}

//MARK: - Setup Views
extension ViewController {
    func setupViews() {
        scoreLabel = makeLabel(
            fontSize: 22,
            weight: .bold,
            alignment: .right,
            textColor: .systemBlue
        )
        scoreLabel.text = "Score: 0"
        
        levelLabel = makeLabel(
            fontSize: 22,
            weight: .bold,
            alignment: .left,
            textColor: .systemBlue
        )
        levelLabel.text = "Level: 1"
        
        
        cluesLabel = makeLabel(fontSize: 18, weight: .regular)
        if let customFont = UIFont(name: "Chalkboard SE", size: 30) {
            cluesLabel.font = customFont
        } else {
            cluesLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        }
        cluesLabel.numberOfLines = 0
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        cluesLabel.backgroundColor = .green
        
        answersLabel = makeLabel(alignment: .center, textColor: .systemBlue)
        if let customFont = UIFont(name: "Avenir Next", size: 30) {
            answersLabel.font = customFont
        } else {
            answersLabel = makeLabel(fontSize: 18, weight: .regular)
        }
        answersLabel = makeLabel(
            alignment: .center,
            textColor: .white
        )
        answersLabel.numberOfLines = 0
        answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        answersLabel.backgroundColor = .systemCyan
        
        correctAnswer = makeTextField(
            fontSize: 18,
            weight: .bold,
            alignment: .center,
            placeholder: "O que é, o que é ?",
            textColor: .darkGray
        )
        correctAnswer.isUserInteractionEnabled = false
        
        submitButton = makeButton(
            title: "Submit",
            backgroundColor: .systemGreen,
            action: #selector(submitTapped),
            target: self
        )
        
        clearButton = makeButton(
            title: "Clear",
            backgroundColor: .systemRed,
            action: #selector(clearTapped),
            target: self
        )
        
        buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.layer.cornerRadius = 25
        buttonsView.backgroundColor = .purple
        
    }
}

// MARK: - Setup Hierarchy
extension ViewController {
    func setupHierarchy() {
        view.addSubview(scoreLabel)
        view.addSubview(levelLabel)
        view.addSubview(cluesLabel)
        view.addSubview(answersLabel)
        view.addSubview(correctAnswer)
        view.addSubview(submitButton)
        view.addSubview(clearButton)
        view.addSubview(buttonsView)
    }
}

// MARK: - Setup Constraints
extension ViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            levelLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            levelLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            
            cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 60),
            cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.7, constant: -60),
            
            answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -60),
            answersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.3, constant: -60),
            answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
            
            correctAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            correctAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            correctAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20),
            
            submitButton.topAnchor.constraint(equalTo: correctAnswer.bottomAnchor),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            submitButton.heightAnchor.constraint(equalToConstant: 44),
            
            clearButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            clearButton.centerYAnchor.constraint(equalTo: submitButton.centerYAnchor),
            clearButton.heightAnchor.constraint(equalToConstant: 44),
            
            buttonsView.widthAnchor.constraint(equalToConstant: 680),
            buttonsView.heightAnchor.constraint(equalToConstant: 320),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 20),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
        ])
        
        let width = 112
        let height = 63
        
        for row in 0..<5 {
            for column in 0..<6 {
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 18) //, weight: .bold)
                letterButton.setTitleColor(.white, for: .normal)
                letterButton.backgroundColor = .systemIndigo
                letterButton.layer.cornerRadius = 16
                letterButton.setTitle("W", for: .normal) // temporário
                
                // Calcule a moldura deste botão usando suas colunas e linhas
                let frame = CGRect(x: column * width, y: row * height, width: width, height: height)
                letterButton.frame = frame
                
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
                letterButton.addTarget(self, action: #selector(letterTapped(_:)), for: .touchUpInside) //(letterTapped), for: .touchUpInside)
            }
        }
    }
}

//MARK: - Make Label and Button
extension ViewController {
    func makeLabel(fontSize: CGFloat = 22, weight: UIFont.Weight = .bold, alignment: NSTextAlignment = .left, textColor: UIColor = .black ) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        label.textAlignment = alignment
        label.textColor = textColor
        return label
    }
    
    func makeTextField(fontSize: CGFloat = 18, weight: UIFont.Weight = .bold, alignment: NSTextAlignment = .left, placeholder: String = "", textColor: UIColor = .black) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        textField.textAlignment = alignment
        textField.placeholder = placeholder
        textField.textColor = textColor
        
        return textField
    }
    
    func makeButton(title: String, backgroundColor: UIColor = .purple, titleColor: UIColor = .white, cornerRadius: CGFloat = 8, action: Selector? = nil, target: Any? = nil) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = cornerRadius
        
        if let action = action, let target = target {
            button.addTarget(target, action: action, for: .touchUpInside)
        }
        return button
    }
}

// MARK: - Actions
extension ViewController {
    
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
        
        correctAnswer.text = correctAnswer.text?.appending(buttonTitle)
        activatedButtons.append(sender)
        sender.isHidden = true
    }
    
    @objc func submitTapped(_ sender: UIButton) {
        guard let answerText = correctAnswer.text else { return }
        
        if let solutionPosition = solutions.firstIndex(of: answerText) {
            activatedButtons.removeAll()
            
            var splitAnswers = answersLabel.text?.components(separatedBy: "\n")
            splitAnswers?[solutionPosition] = answerText
            answersLabel.text = splitAnswers?.joined(separator: "\n")
            
            correctAnswer.text = ""
            score += 1
            
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
    
    @objc func clearTapped(_ sender: UIButton) {
        correctAnswer.text = ""
        
        for button in activatedButtons {
            button.isHidden = false
        }
        
        activatedButtons.removeAll()
    }
    
}

// MARK: - Game Logic
extension ViewController {
    
    func levelUp(action: UIAlertAction) {
        
        score = 0
        level += 1
        
        solutions.removeAll(keepingCapacity: true)
        loadLevel()
        
        for button in letterButtons {
            button.isHidden = false
        }
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
