import CoreImage
import UIKit

// MARK: - Filter Enum
enum FilterType: String, CaseIterable {
    case bumpDistortion = "CIBumpDistortion"
    case gaussianBlur = "CIGaussianBlur"
    case pixellate = "CIPixellate"
    case sepiaTone = "CISepiaTone"
    case twirlDistortion = "CITwirlDistortion"
    case unsharpMask = "CIUnsharpMask"
    case vignette = "CIVignette"
    case blendMode = "CIBlendMode"
    case blendWithMask = "CIBlendWithMask"
    case colorControls = "CIColorControls"
    
    var displayName: String {
        switch self {
            case .bumpDistortion: return "Bump Distortion"
            case .gaussianBlur: return "Gaussian Blur"
            case .pixellate: return "Pixellate"
            case .sepiaTone: return "Sepia Tone"
            case .twirlDistortion: return "Twirl Distortion"
            case .unsharpMask: return "Unsharp Mask"
            case .vignette: return "Vignette"
            case .blendMode: return "Blend Mode"
            case .blendWithMask: return "Blend With Mask"
            case .colorControls: return "Color Controls"
        }
    }
}

// MARK: - View Controller
class EditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var imageEdit: UIImageView!
    @IBOutlet var intensity: UISlider!
    
    // MARK: - Properties
    var currentImage: UIImage!
    var context: CIContext!
    var currentFilter: CIFilter!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Instafilter"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
        
        context = CIContext()
        currentFilter = CIFilter(name: "CISepiaTone")  //"CIColorControls")!
    }
}

// MARK: - Image Picker
extension EditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }
        //imageEdit.image = image
        dismiss(animated: true)
        currentImage = image
        
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    @IBAction func changeFilter(_ sender: UIButton) {
        
        let ac = UIAlertController(title: "Choose filter", message: nil, preferredStyle: .actionSheet)
        
        for filter in FilterType.allCases {
            ac.addAction(UIAlertAction(title: filter.displayName, style: .default, handler: { [weak self] _ in
                self?.setFilter(filter)
            }))
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel)) //, handler: setFilter))
        
        if let popoverController = ac.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = sender.bounds
        }
        
        present(ac, animated:true)
    }
    
    func setFilter(_ filter: FilterType) { // (action: UIAlertAction) {
        
        guard currentImage != nil else { return }
        //guard let actionTitle = action.title else { return }
        
        currentFilter = CIFilter(name: filter.rawValue) //(name: actionTitle)
        
        let beginImage = CIImage(cgImage: currentImage as! CGImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        
        applyProcessing()
    }
    
    @IBAction func save(_ sender: Any) {
        guard let image = imageEdit.image else { return }
        UIImageWriteToSavedPhotosAlbum(image,self, nil, nil)// #selector(image(_:didFinishSavingWithError:contextInfo:)),
    }
    
    @IBAction func intensityChanged(_ sender: Any) {
        applyProcessing()
    }
    
    func applyProcessing() {
        
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey)
        }
        
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(intensity.value * 200, forKey: kCIInputRadiusKey)
        }
        
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(intensity.value * 10, forKey: kCIInputScaleKey)
        }
        
        if inputKeys.contains(kCIInputCenterKey) {
            currentFilter.setValue(CIVector(x: currentImage.size.width / 2, y: currentImage.size.height / 2), forKey: kCIInputCenterKey)
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let processedImage = UIImage(cgImage: cgImage)
            imageEdit.image = processedImage
        }
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(title: "Save Error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else  {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title:"OK", style: .default))
            present(ac, animated: true)
        }
    }
}
