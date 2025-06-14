import UIKit

class TableViewController: UITableViewController {
    
    var petitions = [PetitionModal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Registrar uma célula padrão
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let urlString: String = "https://www.hackingwithswift.com/samples/petitions-1.json"
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    parse(json: data)
            } else {
                print("❌ Falha ao carregar os dados.")
            }
            }.resume()
    }
    
        func parse(json: Data) {
            let decoder = JSONDecoder()
            
            if let jsonPetitions = try? decoder.decode(PetitionResponse.self, from: json) {
                petitions = jsonPetitions.results
                //tableView.reloadData()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                print("❌ Erro ao decodificar JSON")
            }
        }
       /* do {
            let decoded = try decoder.decode(PetitionResponse.self, from: json)
            petitions = decoded.results
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("❌ Erro ao decodificar JSON: \(error)")
        }*/
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
}


