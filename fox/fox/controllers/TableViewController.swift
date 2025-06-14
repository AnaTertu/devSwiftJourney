import UIKit

class TableViewController: UITableViewController {
    
    var petitions = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Registrar uma célula padrão
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = petitions[indexPath.row]
        cell.textLabel?.text = "Title goes here"
        cell.detailTextLabel?.text = "Description goes here"
        return cell
    }
}

