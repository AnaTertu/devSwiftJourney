import UIKit

enum Shift: String {
    case morning = "Good morning "
    case night = "Good night "
}

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var image: UIImageView!
    
    
    var shift: Shift = .morning
    var name: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    
    func setLayout() {
        view.backgroundColor = UIColor(named: shift == .morning ? "Yellow" : "Violet")
        
        label.text = "\(shift.rawValue) \(name) !"
        label.textColor = UIColor(named: shift == .morning ? "Orange" : "Purple")
        
        image.image = UIImage(named: shift == .morning ? "janelaDia" : "janelaNoite")
    }
   
    @IBAction func climateSet(_ sender: Any) {
        self.shift = shift == .morning ? .night : .morning
        setLayout( )
    }
    
    @IBAction func nameSet(_ sender: Any) {
        name = textField.text ?? ""
        textField.text = ""
        setLayout( )
    }
    
}

