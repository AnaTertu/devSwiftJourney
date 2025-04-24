import UIKit

enum Shift: String {
    case day = "Good morning"
    case night = "Good night"
}

class ViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var shift: Shift = .day
    var name: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        
        textField.delegate = self
    }
    
    func setLayout(){
        view.backgroundColor = UIColor(named: shift == .day ? "dayBackground" : "nightBackground")
        label.text = "\(shift.rawValue) \(name) !"
        label.textColor = UIColor(named: shift == .day ? "dayText" : "nightText")
        image.layer.cornerRadius = 40
        image.clipsToBounds = true
        image.image =  UIImage(named: shift == .day ? "dayWindow" : "nightWindow")
        
        
    }

    @IBAction func ChangeShiftButtom(_ sender: Any) {
        self.shift = shift == .day ? .night : .day
        setLayout( )
    }
    
    @IBAction func changeNameButtom(_ sender: Any) {
        name = textField.text ?? ""
        textField.text = ""
        setLayout()
    }
    
    // a segue vai chamar essa função qdo botão for clicado
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetailsShift" { // aqui desemcapsulamos a view controller guardando numa constante que vai receber o destino dessa segue
            let detailsShiftViewController = segue.destination as! DetailsShiftViewController // usamos force ! pq sabemos q é essa class
            detailsShiftViewController.shift = self.shift // a shift da deteils recebe a shift desta página, passamos qual é o turno de uma tela pra a outra
            detailsShiftViewController.view.backgroundColor = self.view.backgroundColor
            // hierarquica
        }
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = .yellow
        textField.textColor = .red
    }
}

