import UIKit

class DetailsShiftViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    
    var shift: Shift?  // como dado vem de outra tela não temos certeza se foi carregado por isso Optional

    override func viewDidLoad() {
        super.viewDidLoad()

        setLayout()
    }
    
    func setLayout() {
        
        guard let shift else { return }
        
        self.image.image = UIImage(named: shift == .day ? "sunnyDay" : "starryNight")
        
    }
}
