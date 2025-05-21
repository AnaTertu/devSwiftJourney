//
//  ViewController.swift
//  projectOne
//
//  Created by ana on 19/05/25.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let fm = FileManager.default // irá procurar arquivo
        let path = Bundle.main.resourcePath! //onde posso encontrar todas as imagens que adicionei ao meu aplicativo
        let items = try! fm.contentsOfDirectory(atPath: path) //é definida como o conteúdo do diretório em um caminho. Do caminho que foi retornado pela linha anterior.
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
                
                print(" encontrado item : ", item)
            }
        }
        
        print(" encontrada ", pictures)
        /*
         
         let path = Bundle.main.resourcePath! //onde posso encontrar todas as imagens que adicionei ao meu aplicativo
         let items = try! fm.contentsOfDirectory(atPath: path) //é definida como o conteúdo do diretório em um caminho. Do caminho que foi retornado pela linha anterior.
         
         for item in items {
             if item.hasPrefix("nssl") {
         */
        }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        cell.imageView?.image = UIImage(named: pictures[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //  1: try to load the "Detail" view controller and cast it to DetailViewController //1: tente carregar o controlador de visualização "Detail" e convertê-lo para DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            
            // 2: success! Set its selectedImage property  // Defina sua propriedade selectedImage
            vc.selectedImage = pictures[indexPath.row]
            
            // 3: now push it onto the navigation controller //3: agora envie-o para o controlador de navegação
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}
