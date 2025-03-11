import UIKit

class DetailsShiftViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    
    var shift: Shift?  // como dado vem de outra tela não temos certeza se foi carregado por isso Optional

    override func viewDidLoad() {
        super.viewDidLoad()

        setLayout()
        // Do any additional setup after loading the view.
    }
    
    func setLayout() {
        
        guard let shift else { return }
        
        self.image.image = UIImage(named: shift == .day ? "sunnyDay" : "starryNight")
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
