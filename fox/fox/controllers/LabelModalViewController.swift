import UIKit

class LabelModalViewController: UIViewController {
   
    
    let labelService = LabelService()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        labelService.view = self.view  // MUITO IMPORTANTE
        labelService.setupLabels()
        labelService.setupLabelConstraints()
    }
}
