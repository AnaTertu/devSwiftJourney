import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var image: UIImageView!

    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var labels: [UILabel] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLabels()
        setupLabelConstraints()
        fetchGreeting()
        fetchFoxImage()
        fetchRandomFact()
        
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
    }
    
    func setupLabels() {
        let textsAndColors: [(String, UIColor)] = [
            ("Red", .red),
            ("Blue", .blue),
            ("Green", .green),
            ("Yellow", .yellow),
            ("Orange", .orange),
            ("Purple", .purple),
            ("Brown", .brown),
            ("Cyan", .cyan),
            ("Magenta", .magenta)
        ]
        
        for (text, color) in textsAndColors {
            let labelA = createLabel(text: text, backgroundColor: color)
            labels.append(labelA)
            view.addSubview(labelA)
        }
        
    }
    
    func setupLabelConstraints() {
        
        let label1 = labels[0]
        let label2 = labels[1]
        let label3 = labels[2]
        let label4 = labels[3]
        let label5 = labels[4]
        let label6 = labels[5]
        let label7 = labels[6]
        let label8 = labels[7]
        let label9 = labels[8]

        let views: [String: UIView] = [
            "label1": label1, "label2": label2,
            "label3": label3, "label4": label4,
            "label5": label5
        ]
        
        for key in views.keys {
            view.addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat: "H:|[\(key)]|",
                options: [], metrics: nil, views: views
            ))
        }
        
        view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[label1]-[label2]-[label3]-[label4]-[label5]",
            options: [], metrics: nil, views: views
        ))
        
        NSLayoutConstraint.activate([
            label6.topAnchor.constraint(equalTo: label5.bottomAnchor, constant: 20),
            label7.topAnchor.constraint(equalTo: label6.bottomAnchor, constant: 10),
            label8.topAnchor.constraint(equalTo: label7.bottomAnchor, constant: 10),
            label9.topAnchor.constraint(equalTo: label8.bottomAnchor),
           // label0.topAnchor.constraint(equalTo: label9.bottomAnchor),

            label6.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            label6.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            label7.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            label7.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
        ])
        
        /* / Aplica constraints horizontais para todos os labels: ocupando toda a largura
        for label in labels {
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                label.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        }
        
        // Empilha os labels verticalmente com espaçamento
        for i in 0..<labels.count {
            if i == 0 {
                labels[i].topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            } else {
                labels[i].topAnchor.constraint(equalTo: labels[1-i].bottomAnchor, constant: 8).isActive = true
            }
        }*/
    }

    func fetchGreeting() {
        if let greeting = UserService.shared.getGreeting() {
            DispatchQueue.main.async {
                self.label.text = greeting
            }
        }
    }
    
    func fetchFoxImage() {
        
        FoxService.getRandomFox { fox in
            guard let fox = fox else {
                print("❌ Não foi possível obter a URL da imagem da raposa.")
                return
            }
            
            print("📸 URL recebida: \(fox.image)")
            
            FoxService.getImage(urlString: fox.image) { data in

                guard let data = data, let image = UIImage(data: data) else {
                    print("Falha ao converter dados em imagem.")
                    return
                }
                DispatchQueue.main.async {
                    self.image.image = image
                    print("✅ Imagem exibida com sucesso.")
                }
            }

            
        }
    }
    
    func fetchRandomFact() {
        FactService.getRandomFact { cat, error in
            guard let cat = cat else { return }
            DispatchQueue.main.async {
                self.label.text = cat.data.first
            }
        }
    }
    
    func createLabel(text: String, backgroundColor: UIColor) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = backgroundColor
        label.text = text
        label.sizeToFit()
        return label
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        guard let greeting = textField.text, !greeting.isEmpty else {
                print("Texto vazio não pode ser salvo.")
                return
            }
            UserService.shared.change(greeting: greeting)
            dataLabel.text = greeting
        /*
        UserService.shared.change(greeting: textField.text)
        self.dataLabel.text = textField.text
         */
    }
    
    @IBAction func refreshFoxImage(_ sender: Any) {
        fetchFoxImage()
    }
    
    @IBAction func loadFoxImageTapped(_ sender: Any) {
        loadFoxImageDirectly()
    }
    
    @IBAction func newFactor(_ sender: Any) {
        fetchRandomFact()
    }
    func loadFoxImageDirectly() {
        guard let url = URL(string: "https://randomfox.ca/floof") else {
                print("❌ URL da API inválida")
                return
            }

        var request = URLRequest(url: url)
        request.setValue(
            "Mozilla/5.0 (iPhone; CPU iPhone OS 14_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148",
            forHTTPHeaderField: "User-Agent"
        )
        
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("❌ Erro ao buscar JSON da raposa: \(error.localizedDescription)")
                    return
                }

                guard let data = data else {
                    print("❌ Dados JSON ausentes")
                    return
                }

                do {
                    // Decodifica a resposta JSON
                    let fox = try JSONDecoder().decode(FoxModel.self, from: data)
                    print("📸 URL da imagem recebida: \(fox.image)")

                    // Baixa a imagem
                    guard let imageURL = URL(string: fox.image) else { return }

                    URLSession.shared.dataTask(with: imageURL) { data, _, error in
                        if let error = error {
                            print("❌ Erro ao baixar imagem: \(error.localizedDescription)")
                            return
                        }

                        guard let data = data, let image = UIImage(data: data) else {
                            print("❌ Dados da imagem inválidos")
                            return
                        }

                        DispatchQueue.main.async {
                            self.image.image = image
                        }

                    }.resume()

                } catch {
                    print("❌ Erro ao decodificar JSON: \(error)")
                }
            }.resume()
        }
    
}
       /*
        override func viewDidLoad() {
            super.viewDidLoad()
            /*
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
            */
            
            let label1 = createLabel(text: "Red", backgroundColor: .red)
            let label2 = createLabel(text: "Blue", backgroundColor: .blue)
            let label3 = createLabel(text: "Green", backgroundColor: .green)
            let label4 = createLabel(text: "Yellow", backgroundColor: .yellow)
            let label5 = createLabel(text: "Orange", backgroundColor: .orange)
            let label6 = createLabel(text: "Red", backgroundColor: .red)
            let label7 = createLabel(text: "Blue", backgroundColor: .blue)
            let label8 = createLabel(text: "Green", backgroundColor: .green)
            let label9 = createLabel(text: "Yellow", backgroundColor: .yellow)
            let label0 = createLabel(text: "Orange", backgroundColor: .orange)
            
            /*
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
            */
            
            let labels = [label1, label2, label3, label4, label5, label6, label7, label8, label9, label0]
            
            for label in labels {
                view.addSubview(label)
            }
            
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
        
        func createLabel(text: String, backgroundColor: UIColor) -> UILabel {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.backgroundColor = backgroundColor
            label.text = text
            label.sizeToFit()
            return label
        }
        
        @IBAction func saveButtonClicked(_ sender: Any) {
            
            UserService.shared.change(greeting: textField.text)
            self.dataLabel.text = textField.text
        }
    }
    */

    
    /*
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
*/
