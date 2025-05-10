import UIKit

class ItensTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let appleDevices = Devices()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = editButtonItem
       
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated : true)
        tableView.setEditing(editing, animated: true)
    }
    
    @IBAction func didTapAdd(_ sender: Any) {
        
    }
    
    
}

extension ItensTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let content = appleDevices.getDevice(from: indexPath)
        content.isSelected.toggle()
        
        tableView.reloadData()
        //tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
       
        let deleteAction = UIContextualAction(style: .destructive, title: "Deletar") { (action, view, completionHandler) in
            
            // self.appleDevices.allDevices.remove(at: indexPath.row)
            self.appleDevices.removeDevice(from: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
            
            self.tableView.reloadData()
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Editar") { (action, view, completionHandler) in
            
            self.appleDevices.allDevices[indexPath.row].description = "Editando"
            
            print("Editando...")
            completionHandler(true)
            self.tableView.reloadData()
        }
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        
        return swipeActions
    }
    
}

// comand+optional+seta
extension ItensTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appleDevices.allDevices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
       
        _ = appleDevices.getDevice(from: indexPath)

       
        return cell
    }
    
}
