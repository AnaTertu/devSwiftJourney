import UIKit

class ItensTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let appleDevices = Devices()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
    }
}

extension ItensTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appleDevices.allDevices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        
        let content = appleDevices.getDevice(from: indexPath)
        cell.textLabel?.text = content.name
        cell.detailTextLabel?.text = content.description
        
        return cell
    }
    
}
