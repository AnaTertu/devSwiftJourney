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

    @IBAction func emailSet(_ sender: Any) {
        emailTextField.layer.shadowRadius = 20
    }
    
    @IBAction func passwordSet(_ sender: Any) {
        passwordTextField.layer.shadowRadius = 20
    }
    
    @IBAction func buttonSet(_ sender: Any) {
        button.layer.cornerRadius = 28
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "identifierSeueTableView" {
            let itensTableViewController = segue.destination as! ItensTableViewController
            itensTableViewController.tabBarItem.title = "Itens"
        }
    }
    

}



