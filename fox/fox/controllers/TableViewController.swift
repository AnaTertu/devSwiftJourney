import UIKit

class TableViewController: UITableViewController {
    
    var petitions = [PetitionModal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchJSON()
    }
    
    func fetchJSON() {
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        guard !urlString.isEmpty else {
            print("❌ URL vazia.")
            return
        }
        /*
        //"Roda esse código em uma fila paralela, fora da tela principal (Main Thread), porque isso é uma tarefa importante para o usuário e não deve travar a interface."
        DispatchQueue.global(qos: .userInitiated).async {
         
            [weak self] in
           */
        guard let url = URL(string: urlString) else {
            print("URL inválida: \(urlString)")
            return
        }
        
        /*
                📌 O URLSession.shared.dataTask já é assíncrono!
             Ele já roda fora da thread principal. Não preciso colocar dentro de DispatchQueue.global
         */
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Erro ao carregar os dados: \(error)")
                DispatchQueue.main.async {
                    self.showError()
                }
                return
            }
            
            guard let data = data else {
                print("Nenhum dado retornado pelo servidor.")
                DispatchQueue.main.async {
                    self.showError()
                }
                return
            }
            self.parse(json: data)
        }
        task.resume()
        
        /*
         if let url = URL(string: urlString) {
             URLSession.shared.dataTask(with: urlTask) { data, response, error in
                  parse(json: data)
             } else {
               print("Falha ao carregar os dados.")
             }.resume()
         }
         */
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(PetitionResponse.self, from: json)
            
            DispatchQueue.main.async {
                self.petitions = decodedData.results
                self.tableView.reloadData()
            }
        } catch {
            print("❌ Erro ao decodificar JSON: \(error.localizedDescription)")
        }
    
       /*
        func parse(json: Data) {
            let decoder = JSONDecoder()

            if let jsonPetitions = try? decoder.decode(PetitionResponse.self, from: json) {
                petitions = jsonPetitions.results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                print("❌ Erro ao decodificar JSON")
            }
        }
        */
    }
    
    func showError() {
        DispatchQueue.main.async { [weak self] in
            let ac = UIAlertController(title: "Erro", message: "Ocorreu um problema ao carregar o feed; Verifique sua conexão e tente novamente.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(ac, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        
        //cell.textLabel?.text = petitions[indexPath.row]
        
        let petition = petitions[indexPath.row]
        
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
       
        //cell.textLabel?.text = "Title goes here"
        //cell.detailTextLabel?.text = "Description goes here"
        return cell
   }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}


