import UIKit

class ViewController: UIViewController {
    
    var cluesLabel: UILabel!
    var ansersLbel: UILabel!
    var currentAnswer: UITextField!
    var scoreLabel: UILabel!
    var letterButons = [UIButton]()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .lightGray

        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
