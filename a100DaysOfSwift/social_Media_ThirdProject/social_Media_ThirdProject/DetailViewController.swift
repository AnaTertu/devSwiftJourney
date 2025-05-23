import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: String?
    
                    // Carregou
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
            // Aparecerá
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
            // Apareceu
    func viewDidAppear() {}
    
            // Desaparecerá
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
            //Desapareceu
    func viewDidDisappear() {}
    
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
