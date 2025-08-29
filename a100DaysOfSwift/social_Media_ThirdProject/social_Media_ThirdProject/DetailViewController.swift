import UIKit

// Mark: - View Controller
class DetailViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet var imageView: UIImageView!
    
    // MARK: - Properties
    var selectedImage: String?
    
    // MARK: - Carregar
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedImage
        navigationItem.largeTitleDisplayMode = .never
        
        //criando botão à direita com info
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        if let imageToLoad = selectedImage {
            imageView.image  = UIImage(named: imageToLoad)
        }
    }
    
    // MARK: - Aparecerá
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    // MARK: - Apareceu
    func viewDidAppear() {}
    
    // MARK: Desaparecerá
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    // MARK: - Desapareceu
    func viewDidDisappear() {}
    
    // MARK: - Toque e compartilhe
    @objc func shareTapped() {
        
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8)
        else {
            print("No image found")
            return
        }
        
        let rightBarButtonImport = UIActivityViewController(activityItems: [image], applicationActivities: [])
        rightBarButtonImport.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(rightBarButtonImport, animated: true)
        
    }
}
