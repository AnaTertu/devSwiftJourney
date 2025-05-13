import UIKit

class NewProductModalViewController: UIViewController {
    

    @IBOutlet var newModal: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.view.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        self.newModal.layer.cornerRadius = 20
        self.newModal.clipsToBounds = true
        self.newModal.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.newModal.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
       
        let navBarAppearance = UINavigationBarAppearance()
       
        navBarAppearance.backgroundColor = UIColor(named : "TIC_Green1")
        
        navBarAppearance.shadowColor = UIColor.clear
        
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        self.modalPresentationStyle = .pageSheet
        
        if #available(iOS 15.0, *), let sheet = self.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
    }
    
    @IBAction func didTapAdd(_ sender: Any) {}
    
    @IBAction func closeModal(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}


    
func showNewProductModal(from viewController: UIViewController) {
    let modalViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewProductModalViewController") as! NewProductModalViewController
    modalViewController.modalPresentationStyle = .overFullScreen
    viewController.present(modalViewController, animated: true, completion: nil)
}

func dismissNewProductModal(from viewController: UIViewController) {
    viewController.dismiss(animated: true, completion: nil)
}

func showNewProductModalFromTabBarController(tabBarController: UITabBarController) {
    guard let selectedViewController = tabBarController.selectedViewController else { return }
    showNewProductModal(from: selectedViewController)
}

func dismissNewProductModalFromTabBarController(tabBarController: UITabBarController) {
    guard let selectedViewController = tabBarController.selectedViewController else { return }
    dismissNewProductModal(from: selectedViewController)
}

extension UIViewController {
    func showNewProductModal() {
        newMarket.showNewProductModal(from: self)
        
        newMarket.showNewProductModalFromTabBarController(tabBarController: self as! UITabBarController)
    }
    
    func dismissNewProductModal() {
        newMarket.dismissNewProductModal(from: self)
        newMarket.dismissNewProductModalFromTabBarController(tabBarController: self as! UITabBarController)
    }
}
