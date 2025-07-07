import UIKit

class TableViewController: UITableViewController {
    
    var petitions = [PetitionModal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString: String = "https://www.hackingwithswift.com/samples/petitions-1.json"
        
        guard !urlString.isEmpty else {
            print("❌ URL vazia.")
            return
        }
        
        guard let urlTask = URL(string: urlString) else {
            print("URL inválida: \(urlString)")
            return
        }
        
        let url = URLSession.shared.dataTask(with: urlTask) { data, response, error in
            if let error = error {
                print("❌ Erro ao carregar os dados: \(error)")
                return
            }
            
            guard let data = data else {
                print("Nenhum dado retornado pelo servidor.")
                return
            }
            self.parse(json: data)
        }
        url.resume()
        /*
         if let url = URL(string: urlString) {
             URLSession.shared.dataTask(with: urlTask) { data, response, error in
                  parse(json: data)
             } else {
               print("❌ Falha ao carregar os dados.")
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


