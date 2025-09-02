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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupHierarchy()
        setupConstraints()
        
        loadLevel()
    }
    
}

//MARK: - Setup Views
extension ViewController {
    func setupViews() {
        scoreLabel = makeLabel(alignment: .right)
        scoreLabel.text = "Score: 0"
        scoreLabel = makeLabel(textColor: .systemBlue)
        
        levelLabel = makeLabel(alignment: .left)
        levelLabel = makeLabel(textColor: .systemBlue)
        levelLabel.text = "Level: 1"
        
        if let customFont = UIFont(name: "Chalkboard SE", size: 30) {
            cluesLabel.font = customFont
            cluesLabel = makeLabel(fontSize: 18, weight: .regular)
        } else {
            cluesLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        }
        cluesLabel.numberOfLines = 0
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        cluesLabel.backgroundColor = .green
        
        if let customFont = UIFont(name: "Avenir Next", size: 30) {
            answersLabel.font = customFont
        } else {
            answersLabel = makeLabel(fontSize: 18, weight: .regular)
        }
        answersLabel = makeLabel(alignment: .center)
        answersLabel = makeLabel(textColor: .systemBlue)
        answersLabel.numberOfLines = 0
        answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        answersLabel.backgroundColor = .systemCyan
        
        correctAnswer = makeTextField(alignment: .center)
        correctAnswer = makeTextField(placeholder: "O que é, o que é ?")
        correctAnswer.isUserInteractionEnabled = false
        
        let submitButton = makeButton(
            title: "Submit",
            backgroundColor: .systemGreen,
            action: #selector(submitTapped),
            target: self
        )
        view.addSubview(submitButton)
        
        let clearButton = makeButton(
            title: "Clear",
            backgroundColor: .systemRed,
            action: #selector(clearTapped),
            target: self
        )
        view.addSubview(clearButton)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.layer.cornerRadius = 25
        buttonsView.backgroundColor = .purple
        view.addSubview(buttonsView)
        
    }
}

// MARK: - Setup Hierarchy
extension ViewController {
    func setupHierarchy() {
        view.addSubview(scoreLabel)
        view.addSubview(levelLabel)
        view.addSubview(cluesLabel)
        view.addSubview(answersLabel)
    }
}

// MARK: - Setup Constraints
extension ViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
        ])
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
    
    @objc func submitTapped() {
        
    }
    
    @objc func clearTapped() {
        
    }
}

// MARK: - Game Logic
extension ViewController {
    func loadLevel() {
        
    }
}
