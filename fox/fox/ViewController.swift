import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var image: UIImageView!

    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
