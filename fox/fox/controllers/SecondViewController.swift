import UIKit

class SecondViewController: UIViewController {
    
    let tableButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let label = UILabel()
        label.text = "Nova Tela 🐾"
        label.textColor = .systemBlue
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        tableButton.setTitle("Abrir Tabela", for: .normal)
        tableButton.addTarget(self, action: #selector(AcessoTableButton), for: .touchUpInside)
        tableButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tableButton)
        NSLayoutConstraint.activate([
            tableButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 30),
            tableButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func AcessoTableButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let tabBar = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController {
            navigationController?.pushViewController(tabBar, animated: true)
        }
    }
}
