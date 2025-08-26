import UIKit

class CollectionViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var people = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPeople()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
            fatalError("Unable to dequeue /Não é possível retirar da fila/ PersonCell")
        }
        
        let person = people[indexPath.item]
        
        cell.name.text = person.name
        
        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        cell.imageView.image = UIImage(contentsOfFile: path.path)
        
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        return cell
    }
    
    @objc func addNewPerson() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func savePeople() {
        let jsonEncoder = JSONEncoder()
        
        if let saveData = try? jsonEncoder.encode(people) {
            let defaults = UserDefaults.standard
            defaults.set(saveData, forKey: "people")
        }
    }
    
    func loadPeople() {
        let defaults = UserDefaults.standard
        if let savedData = defaults.object(forKey: "people") as? Data {
            let jsonDecoder = JSONDecoder()
            
            if let savedPeople = try? jsonDecoder.decode([Person].self, from: savedData) {
                people = savedPeople
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let person = Person(name: "Name", image: imageName)
        people.append(person)
        savePeople()
        collectionView.reloadData()
        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    let actionSheet = UIAlertController(title: "O que deseja fazer?", message: nil, preferredStyle: .actionSheet)
    
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let person = people[indexPath.item]
        
        let optionsAlert = UIAlertController(title: "O que deseja fazer?", message: "123", preferredStyle: .alert)
        
        optionsAlert.addAction(UIAlertAction(title: "Renomear", style: .default) { [weak self] _ in
            let renameAlert = UIAlertController(title: "Digite o novo nome", message: nil, preferredStyle: .alert)
            renameAlert.addTextField()
            
            renameAlert.addAction(UIAlertAction(title: "Ök", style: .default) { [weak self, weak renameAlert] _ in
                guard let newName = renameAlert?.textFields?[0].text else { return }
                person.name = newName
                self?.collectionView.reloadData()
            })
            
            renameAlert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
            self?.present(renameAlert, animated: true)
        })
        
        optionsAlert.addAction(UIAlertAction(title: "Local da imagem", style: .default) { [weak self] _ in
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            self?.present(imagePicker, animated: true)
            
        })
        
        optionsAlert.addAction(UIAlertAction(title: "Excluir", style: .destructive) { [weak self] _ in
            self?.people.remove(at: indexPath.item)
            self?.savePeople().self
            self?.collectionView.deleteItems(at: [indexPath])
        })
        
        optionsAlert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        
        present(optionsAlert, animated: true)
    }
}
    /*
     
     override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         
         let person = people[indexPath.item]
         // Renomear
         actionSheet.addAction(UIAlertAction(title: "Renomear", style: .default) { [weak self] _ in
             let renameAlert = UIAlertController(title: "Digite o novo nome", message: nil, preferredStyle: .alert)
             renameAlert.addTextField()
             
             renameAlert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak renameAlert] _ in
                 guard let newName = renameAlert?.textFields?[0].text else { return }
                 person.name = newName
                 self?.collectionView.reloadData()
             })
             
             renameAlert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
             self?.present(renameAlert, animated: true)
         })
         
         // Excluir
         actionSheet.addAction(UIAlertAction(title: "Excluir", style: .destructive) { [weak self] _ in
             self?.people.remove(at: indexPath.item)
             self?.collectionView.deleteItems(at: [indexPath])
         })
         
         // Cancelar
         actionSheet.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
         
         // Importante: para iPad (evita crash)
         if let popover = actionSheet.popoverPresentationController {
             popover.sourceView = collectionView.cellForItem(at: indexPath)
             popover.sourceRect = collectionView.cellForItem(at: indexPath)?.bounds ?? .zero
         }
         
         present(actionSheet, animated: true)
         
     }
     
     
     
     override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let person = people[indexPath.item]
        
        let optionsAlert = UIAlertController(title: "Deseja renomear?", message: nil, preferredStyle: .alert)
        optionsAlert.addTextField()
        
        optionsAlert.addAction(UIAlertAction(title: "ok", style: .default) { [weak self, weak optionsAlert] _ in
            guard let newName = optionsAlert?.textFields?[0].text else { return }
            person.name = newName
            self?.collectionView.reloadData()
        })
        
        optionsAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(optionsAlert, animated: true)
    }
    
    / *
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = people[indexPath.item]

        // Primeiro alerta: deseja renomear?
        let confirm = UIAlertController(title: "Deseja renomear?", message: nil, preferredStyle: .alert)
        
        // Ação: Renomear
        confirm.addAction(UIAlertAction(title: "Renomear", style: .default) { [weak self] _ in
            // Segundo alerta: campo para editar o nome
            let renameAlert = UIAlertController(title: "Novo nome", message: nil, preferredStyle: .alert)
            renameAlert.addTextField()

            renameAlert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak renameAlert] _ in
                guard let newName = renameAlert?.textFields?[0].text else { return }
                person.name = newName
                self?.collectionView.reloadData()
            })

            renameAlert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
            self?.present(renameAlert, animated: true)
        })

        // Ação: Cancelar
        confirm.addAction(UIAlertAction(title: "Cancelar", style: .cancel))

        present(confirm, animated: true)
    }*/
