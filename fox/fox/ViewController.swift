import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var image: UIImageView!

    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = .red
        label1.text = "Red"
        label1.sizeToFit()
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = .blue
        label2.text = "Blue"
        label2.sizeToFit()
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = .green
        label3.text = "Green"
        label3.sizeToFit()
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = .yellow
        label4.text = "Yellow"
        label4.sizeToFit()
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = .orange
        label5.text = "Orange"
        label5.sizeToFit()
        
        let label6 = UILabel()
        label6.translatesAutoresizingMaskIntoConstraints = false
        label6.backgroundColor = .red
        label6.text = "Red"
        label6.sizeToFit()
        
        let label7 = UILabel()
        label7.translatesAutoresizingMaskIntoConstraints = false
        label7.backgroundColor = .blue
        label7.text = "Blue"
        label7.sizeToFit()
        
        let label8 = UILabel()
        label8.translatesAutoresizingMaskIntoConstraints = false
        label8.backgroundColor = .green
        label8.text = "Green"
        label8.sizeToFit()
        
        let label9 = UILabel()
        label9.translatesAutoresizingMaskIntoConstraints = false
        label9.backgroundColor = .yellow
        label9.text = "Yellow"
        label9.sizeToFit()
        
        let label0 = UILabel()
        label0.translatesAutoresizingMaskIntoConstraints = false
        label0.backgroundColor = .orange
        label0.text = "Orange"
        label0.sizeToFit()
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        view.addSubview(label6)
        view.addSubview(label7)
        view.addSubview(label8)
        view.addSubview(label9)
        view.addSubview(label0)
        
        let viewsDictionary: [String: Any] = ["label1": label1, "label2": label2, "label3": label3, "label4" : label4, "label5": label5]
        
        for label in viewsDictionary.keys {
            view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewsDictionary))
            
            
            view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1]-[label2]-[label3]-[label4]-[label5]", options: [], metrics: nil, views: viewsDictionary))
        }
/*
         for _ in viewsDictionary.keys {
             view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1]-[label2]-[label3]-[label4]-[label5]", options: [], metrics: nil, views: viewsDictionary))

         }
         
        view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[label1]|", options: [], metrics: nil, views: viewsDictionary))
        view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[label2]|", options: [], metrics: nil, views: viewsDictionary))
        view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[label3]|", options: [], metrics: nil, views: viewsDictionary))
        view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[label4]|", options: [], metrics: nil, views: viewsDictionary))
        view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[label5]|", options: [], metrics: nil, views: viewsDictionary))
        */
         NSLayoutConstraint.activate([
            label6.topAnchor.constraint(equalTo: label5.bottomAnchor, constant: 20),
            label7.topAnchor.constraint(equalTo: label6.bottomAnchor, constant: 10),
            label8.topAnchor.constraint(equalTo: label7.bottomAnchor, constant: 10),
            label9.topAnchor.constraint(equalTo: label8.bottomAnchor),
            label0.topAnchor.constraint(equalTo: label9.bottomAnchor),
        
            label6.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            label6.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            label7.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            label7.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
        ])
        
        if let greeting = UserService.shared.getGreeting() {
            self.label.text = greeting
        }
        
        FoxService.getRandomFox { fox in guard let fox else { return }
            
            print("URL da imagem.")
            
            FoxService.getImage(urlString: fox.image) { data in
                guard let data else {
                    print("Falha ao carregar dados da imagem")
                    return
                }
                
                print("Imagem baixada com sucesso!")
                
                DispatchQueue.main.async {
                    self.image.image = UIImage(data: data)
                }
            }
        }
        
        FactService.getRandomFact { cat, error in guard let cat = cat else { return }
            
            DispatchQueue.main.async {
                self.label.text = cat.data.first
            }
        }
        
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        UserService.shared.change(greeting: textField.text)
        self.dataLabel.text = textField.text
    }
}
