import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var image: UIImageView!

    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = .red
        label1.text = "Red"
        label1.sizeToFit()
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = .blue
        label2.text = "Blue..........."
        label2.sizeToFit()
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = .green
        label3.text = "Green......."
        label3.sizeToFit()
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = .yellow
        label4.text = "Yellow...."
        label4.sizeToFit()
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = .orange
        label5.text = "Orange"
        label5.sizeToFit()
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
        if let greeting = UserService.shared.getGreeting() {
            self.label.text = greeting
        }
        
        FoxService.getRandomFox { fox in guard let fox else { return }
            
            print("URL da imagem.")
            
            FoxService.getImage(urlString: fox.image) { data in
                guard let data else {
                    print("Falha ao carregar dados da imagem")
                    return
                }
                
                print("Imagem baixada com sucesso!")
                
                DispatchQueue.main.async {
                    self.image.image = UIImage(data: data)
                }
            }
        }
        
        FactService.getRandomFact { cat, error in guard let cat = cat else { return }
            
            DispatchQueue.main.async {
                self.label.text = cat.data.first
            }
        }
        
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        UserService.shared.change(greeting: textField.text)
        self.dataLabel.text = textField.text
    }
}
