import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FactService.getRandomFact { cat, error in guard let cat = cat else { return }
            
            DispatchQueue.main.async {
                self.label.text = cat.data.first
                //self.label.text = cat.data.first?.description
            }
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
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        self.dataLabel.text = textField.text
    }
}

