import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var imageView: UIView!
    @IBOutlet var image: UIImageView!
    @IBOutlet var button: UIButton!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    func setView() {
        imageSet()
        
        imageView.layer.cornerRadius = 24
    }
    
    func imageSet() {
        image.image = UIImage(named: "grocery")
    }
    
    /*
     
     func imageSet() {
         guard let groceryImage = UIImage(named: "grocery") else {
             fatalError("Image named 'grocery' not found.")
         }
         image.image = groceryImage
     }
     
    func imageSet() {
        if let groceryImage = UIImage(named: "grocery") {
            image.image = groceryImage
        } else {
            print("Error: Image named 'grocery' not found.")
        }
    }*/

    @IBAction func emailSet(_ sender: Any) {
        emailTextField.layer.shadowRadius = 20
    }
    
    @IBAction func passwordSet(_ sender: Any) {
        passwordTextField.layer.shadowRadius = 20
    }
    
    @IBAction func buttonSet(_ sender: Any) {
        button.layer.cornerRadius = 28
    }
    

}



