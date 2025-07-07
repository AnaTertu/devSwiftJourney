import UIKit

class ViewController: UIViewController {
    
    let image = UIImageView()
    let labelFox = UILabel()
    let dataLabel = UILabel()
    let textField = UITextField()
    let showButton = UIButton(type: .system)
    let graveButton = UIButton(type: .system)
    let modalButton = UIButton(type: .system)
    let newFactorBotton = UIButton(type: .system)
    
    override func loadView() {
        super.loadView()
        print("📦 loadView — a view está sendo carregada manualmente (caso você customize).")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("🔵 viewDidLoad - ideal para configurar a interfacce e carregar dados iniciais.")
        
        view.backgroundColor = .systemBackground
        
        setupViews()
        setupStackView()
        setupConstraints()
        setupButtonAction()
    
        //setupLabels()
        //setupLabelConstraints()
        
        fetchFoxImage()
        fetchRandomFact()
        
        labelFox.numberOfLines = 0
        labelFox.lineBreakMode = .byWordWrapping
        labelFox.textAlignment = .center
        labelFox.font = UIFont.systemFont(ofSize: 18)
        
        //textField.widthAnchor.constraint(equalTo: dataLabel.widthAnchor).isActive = true
        //textField.heightAnchor.constraint(equalToConstant: 39).isActive = true
        
        // Modo escuro / claro detection via nova API (iOS 17+)
        if #available(iOS 17.0, *) {
            // Registra mudança de traits (modo claro/escuro, size class etc.)
            registerForTraitChanges([UITraitUserInterfaceStyle.self]) { [weak self] (_: ViewController, previousTraitCollection) in
                self?.traitDidChange(previousTraitCollection)
            }
        }
        
        

    }
   
    //PART TWO
    func setupViews() {
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(image)
        
        labelFox.numberOfLines = 0
        labelFox.textAlignment = .center
        labelFox.font = UIFont.systemFont(ofSize: 18)
        labelFox.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelFox)
        
        
        dataLabel.textAlignment = .center
        //dataLabel.translatesAutoresizingMaskIntoConstraints = false
        dataLabel.backgroundColor = .lightGray
        view.addSubview(dataLabel)
        
        textField.borderStyle = .roundedRect
        //textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Qual nome do seu pet?"
        view.addSubview(textField)
        /*
        Estado          Significado
        .normal         Estado padrão (sem interação)
        .highlighted    Quando está sendo tocado
        .disabled       Quando está desabilitado
        .selected       Quando está selecionado (como toggle)
        */
        
        newFactorBotton.setTitle("Novo Fato", for: .normal)
        newFactorBotton.tintColor = .systemBlue
        newFactorBotton.titleLabel?.textAlignment = .center
        newFactorBotton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        view.addSubview(newFactorBotton)
        
        graveButton.setTitle("Grave", for: .normal)
        graveButton.tintColor = .systemBlue
        graveButton.titleLabel?.textAlignment = .center
        graveButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        view.addSubview(graveButton)
        
        showButton.setTitle("Próxima página", for: .normal)
        showButton.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        showButton.tintColor = .white
        showButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        //showButton.translatesAutoresizingMaskIntoConstraints = false
        showButton.backgroundColor = .systemBlue
        showButton.titleLabel?.textAlignment = .center
        showButton.layer.cornerRadius = 5
        view.addSubview(showButton)
        
        modalButton.setTitle("Modal", for: .normal)
        modalButton.setImage(UIImage(systemName: "info.circle"), for: .normal)
        modalButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        modalButton.tintColor = .systemBlue
        modalButton.titleLabel?.textAlignment = .center
        view.addSubview(modalButton)
         
    }

    func setupStackView() {
        // horizontal stack para textField + dataLabel
        
        let inputStackNew = UIStackView(arrangedSubviews: [newFactorBotton, showButton, modalButton])
        inputStackNew.axis = .horizontal
        inputStackNew.spacing = 5
        inputStackNew.distribution = .fillProportionally
        
        let inputStack = UIStackView(arrangedSubviews: [textField, graveButton, dataLabel])
        inputStack.axis = .horizontal
        inputStack.spacing = 16
        inputStack.distribution = .fillEqually

        // vertical stack principal
        let mainStack = UIStackView(arrangedSubviews: [inputStackNew, inputStack])
        mainStack.axis = .vertical
        mainStack.spacing = 10
        mainStack.alignment = .center
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(mainStack)

        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            mainStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])
    }

    func setupConstraints() {
        let safe = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: 200),
            image.heightAnchor.constraint(equalTo: image.widthAnchor, multiplier: 1.0),
            
            // 🦊 Image constraints
            //image.topAnchor.constraint(greaterThanOrEqualTo: safe.topAnchor, constant: 107),//
            //image.bottomAnchor.constraint(lessThanOrEqualTo: safe.bottomAnchor, constant: -470),
            image.leadingAnchor.constraint(greaterThanOrEqualTo: safe.leadingAnchor, constant: 130),
            image.trailingAnchor.constraint(greaterThanOrEqualTo: safe.trailingAnchor, constant: -143),
              //image.widthAnchor.constraint(greaterThanOrEqualToConstant: 115),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),//
            
              //image.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 20),
              //image.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -20),

            // Mantém a proporção da imagem original (altura proporcional à largura)
            image.heightAnchor.constraint(equalTo: image.widthAnchor, multiplier: 0.75),

            // 🐱 LabelFox constraints
            labelFox.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20),
            labelFox.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 38),
            labelFox.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -47),
            labelFox.heightAnchor.constraint(greaterThanOrEqualToConstant: 132),

        ])
    }
    
    // PART THREE
    func setupButtonAction() {
        
        newFactorBotton.addTarget(self, action: #selector(newFactorClicked), for: .touchUpInside)
        
        graveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)

        showButton.addTarget(self, action: #selector(showNewScreen), for: .touchUpInside)
        
        modalButton.addTarget(self, action: #selector(modalButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("🟢 viewWillAppear - chamado antes da view aparecer.")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("📐 viewWillLayoutSubviews - antes do Auto Layout ajustar as views")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("📏 viewDidLayoutSubviews - depois do Auto Layout ajustar as views.")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("✅ viewDidAppear - a view apareceu na tela.")
        adjustLayoutForOrientation()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        print("🔄 viewWillTransition - mudança de orientação detectada.")
        
        coordinator.animate(alongsideTransition: { _ in
            self.adjustLayoutForOrientation()
        })
    }
    
    private func traitDidChange(_ previousTraitCollection: UITraitCollection?) {
        print("🌗 Mudança de trait detectada — ex: modo claro/escuro mudou.")
        
        if traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle {
            print("➡️ Modo claro/escuro foi alterado.")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("🟠 viewWillDisappear - antes da view sumir.")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(("🔴 viewDidDisappear - depois que a viu sumiu."))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("⚠️ didReceiveMemoryWarning - app com pouca memória.")
    }
    
    func fetchRandomFact() {
        FactService.getRandomFact { fox, error in
            guard let fox = fox else { return }
            DispatchQueue.main.async {
                self.labelFox.text = fox.data.first
            }
        }
    }
    
    
    // PART FOUR
    func fetchFoxImage() {
        
        FoxService.getRandomFox { fox in
            guard let fox = fox else {
                print("❌ Não foi possível obter a URL da imagem da raposa.")
                DispatchQueue.main.async {
                    self.setDefaultImage()
                }
                return
            }
            
            print("📸 URL recebida: \(fox.image)")
            
            FoxService.getImage(urlString: fox.image) { data in
                DispatchQueue.main.async {
                    guard let data = data, let downloadedImage = UIImage(data: data) else {
                    print("❌ Falha ao converter dados em imagem.")
                    self.setDefaultImage()
                    return
                }
                    
                    self.image.image = downloadedImage
                    // Remove constraints de altura antigas (se houver)
                    self.image.constraints
                        .filter { $0.firstAttribute == .height }
                        .forEach { $0.isActive = false }

                    // Adiciona nova constraint com proporção da imagem
                    let aspectRatio = downloadedImage.size.height / downloadedImage.size.width
                    let newHeightConstraint = self.image.heightAnchor.constraint(equalTo: self.image.widthAnchor, multiplier: aspectRatio)
                    newHeightConstraint.priority = .defaultHigh
                    newHeightConstraint.isActive = true

                    // Atualiza layout
                    self.view.layoutIfNeeded()
                    print("✅ Imagem exibida com sucesso com aspectRatio \(aspectRatio).")
                }
            }
   
        }
    }
    
    func setDefaultImage() {
        guard let defaultImage = UIImage(named: "defaultFox") else {
            print("⚠️ Imagem padrão 'defaultFox' não encontrada no Assets.xcassets.")
            return
        }

        // Aplica imagem padrão
        image.image = defaultImage

        // Remove constraints de altura anteriores da UIImageView
        image.constraints
            .filter { $0.firstAttribute == .height }
            .forEach { $0.isActive = false }

        // Calcula o aspect ratio da imagem padrão
        let aspectRatio = defaultImage.size.height / defaultImage.size.width

        // Cria nova constraint de altura proporcional à largura
        let heightConstraint = image.heightAnchor.constraint(equalTo: image.widthAnchor, multiplier: aspectRatio)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true

        // Atualiza o layout imediatamente
        view.layoutIfNeeded()

        print("📎 Imagem padrão aplicada com aspectRatio: \(aspectRatio)")
    }
    
    func chameLabelModal() {
        let alertController = UIAlertController(title: "Opa!", message: "Você está no modal de um alert!", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            print("O usuário clicou no OK.")
        }
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
    // PART FIVE
    @IBAction func showNewScreen(_ sender: UIButton) {
        let secondVC = SecondViewController()
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        guard let greeting = textField.text, !greeting.isEmpty else {
            print("Texto vazio não pode ser salvo.")
            return
        }
        UserService.shared.change(greeting: greeting)
        dataLabel.text = greeting
    }
    
    @IBAction func refreshFoxImage(_ sender: Any) {
        fetchFoxImage()
    }
    
    @IBAction func loadFoxImageTapped(_ sender: Any) {
        loadFoxImageDirectly()
    }
    
    @objc func newFactorClicked() {
        fetchRandomFact()
    }
    
    func loadFoxImageDirectly() {
        guard let url = URL(string: "https://randomfox.ca/floof") else {
            self.image.image = UIImage(named: "defaultFox") // imagem padrão
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
  
    @objc func modalButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //let modalVC = LabelModalViewController()
        if let modalVC = storyboard.instantiateViewController(withIdentifier: "LabelModalViewController") as? LabelModalViewController {
            modalVC.modalPresentationStyle = .formSheet // ou .pageSheet, .fullScreen
            present(modalVC, animated: true)
        }  else {
            print("❌ Não foi possível encontrar a LabelModalViewController no storyboard.")
        }
    }
    //Ao clicar no botão "vireButton", o modal será exibido com todas as labels geradas dinamicamente pela LabelService.
    
    func adjustLayoutForOrientation() {
        guard let orientation = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first?.interfaceOrientation else {
            return
        }
        
        let isLandscape = orientation.isLandscape
        
        image.isHidden = isLandscape
    }
}
         /*
          
          
          /*
           /*
               func setupStackView() {
                   let stackView = UIStackView(arrangedSubviews: [textField, dataLabel, showButton])
                   stackView.axis = .vertical
                   stackView.spacing = 16
                   stackView.alignment = .fill
                   stackView.distribution = .equalSpacing
                   stackView.translatesAutoresizingMaskIntoConstraints = false
                   
                   view.addSubview(stackView)

                   // Constraints para posicionar o stackView no final da tela
                   NSLayoutConstraint.activate([
                       stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                       stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                       stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
                   ])
               }
               */
           
           
           /* / ✍️ TextField constraints
           textField.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 20),
           textField.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -20),
           textField.widthAnchor.constraint(equalToConstant: 170),
           textField.heightAnchor.constraint(equalToConstant: 39),

           // 📅 DataLabel constraints
           dataLabel.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -23),
           dataLabel.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -20),
           dataLabel.widthAnchor.constraint(equalToConstant: 170),
           dataLabel.heightAnchor.constraint(equalToConstant: 39),

           // 📘 Show Button
           showButton.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -77),
           showButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           showButton.widthAnchor.constraint(equalToConstant: 160),
           showButton.heightAnchor.constraint(equalToConstant: 35)
            */
           */
          
          class ViewController: UIViewController {
              //, UITraitChangeObservable {
              
             /* @IBOutlet weak var labelCat: UILabel! //
              @IBOutlet weak var image: UIImageView! //
              
              @IBOutlet weak var dataLabel: UILabel! //
              @IBOutlet weak var textField: UITextField! //
              
              @IBOutlet var showButton: UIButton! //
              //let showButton = UIButton(type: .system)
              */
              let image = UIImageView()
              let labelCat = UILabel()
              let dataLabel = UILabel()
              let textField = UITextField()
              let showButton = UIButton(type: .system)
              
              override func loadView() {
                  super.loadView()
                  print("📦 loadView — a view está sendo carregada manualmente (caso você customize).")
              }
              
              override func viewDidLoad() {
                  super.viewDidLoad()
                  print("🔵 viewDidLoad - ideal para configurar a interfacce e carregar dados iniciais.")
                  
                  view.backgroundColor = .systemBackground
                  
                  setupViews()
                  setupConstraints()
                  setupButtonAction()
                  
                  //setupLabels()
                  //setupLabelConstraints()
                  
                  fetchGreeting()
                  fetchFoxImage()
                  fetchRandomFact()
                  
                  labelCat.numberOfLines = 0
                  labelCat.lineBreakMode = .byWordWrapping
                  labelCat.textAlignment = .center
                  labelCat.font = UIFont.systemFont(ofSize: 18)
                  
                  textField.widthAnchor.constraint(equalTo: dataLabel.widthAnchor).isActive = true
                  textField.heightAnchor.constraint(equalToConstant: 39).isActive = true
                  
                  //adjustLayoutForOrientation()
                  
                  // Modo escuro / claro detection via nova API (iOS 17+)
                  if #available(iOS 17.0, *) {
                      // Registra mudança de traits (modo claro/escuro, size class etc.)
                      registerForTraitChanges([UITraitUserInterfaceStyle.self]) { [weak self] (_: ViewController, previousTraitCollection) in
                          self?.traitDidChange(previousTraitCollection)
                      }
                  }
                  
                  // Configuração do botão
                  //showButton.setTitle("Abrir nova tela", for: .normal)
                  //showButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
                  //showButton.translatesAutoresizingMaskIntoConstraints = false
                  //showButton.addTarget(self, action: #selector(showNewScreen), for: .touchUpInside)
                  view.addSubview(showButton)
                  
                  /*/ Layout
                          NSLayoutConstraint.activate([
                              showButton.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 40),
                              showButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
                          ])
                   */

              }
              
              func setupViews() {
                  image.contentMode = .scaleAspectFit
                  image.translatesAutoresizingMaskIntoConstraints = false
                  view.addSubview(image)
                  
                  labelCat.numberOfLines = 0
                  labelCat.textAlignment = .center
                  labelCat.font = UIFont.systemFont(ofSize: 18)
                  labelCat.translatesAutoresizingMaskIntoConstraints = false
                  view.addSubview(labelCat)
                  
                  dataLabel.textAlignment = .right
                  dataLabel.translatesAutoresizingMaskIntoConstraints = false
                  view.addSubview(dataLabel)
                  
                  textField.borderStyle = .roundedRect
                  textField.translatesAutoresizingMaskIntoConstraints = false
                  view.addSubview(textField)
                  
                  showButton.setTitle("Próxima página", for: .normal)
                  showButton.setImage(UIImage(systemName: "plus.circle"), for: .normal)
                  showButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
                  showButton.translatesAutoresizingMaskIntoConstraints = false
                  showButton.addSubview(showButton)
              }
              
              func setupConstraints() {
                  let safe = view.safeAreaLayoutGuide
                  
                  NSLayoutConstraint.activate([
                      // 🦊 Image constraints
                      image.topAnchor.constraint(greaterThanOrEqualTo: safe.topAnchor, constant: 107),
                      image.bottomAnchor.constraint(lessThanOrEqualTo: safe.bottomAnchor, constant: -470),
                      image.leadingAnchor.constraint(greaterThanOrEqualTo: safe.leadingAnchor, constant: 130),
                      image.trailingAnchor.constraint(greaterThanOrEqualTo: safe.trailingAnchor, constant: -143),
                      image.widthAnchor.constraint(greaterThanOrEqualToConstant: 115),
                      image.centerXAnchor.constraint(equalTo: view.centerXAnchor),

                      // 🐱 LabelCat constraints
                      labelCat.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20),
                      labelCat.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 38),
                      labelCat.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -47),
                      labelCat.heightAnchor.constraint(greaterThanOrEqualToConstant: 132),

                      // ✍️ TextField constraints
                      textField.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 20),
                      textField.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -20),
                      textField.widthAnchor.constraint(equalToConstant: 170),
                      textField.heightAnchor.constraint(equalToConstant: 39),

                      // 📅 DataLabel constraints
                      dataLabel.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -23),
                      dataLabel.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -20),
                      dataLabel.widthAnchor.constraint(equalToConstant: 170),
                      dataLabel.heightAnchor.constraint(equalToConstant: 39),

                      // 📘 Show Button
                      showButton.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -77),
                      showButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
                  ])
              }
              
              func setupButtonAction() {
                  showButton.addTarget(self, action: #selector(showNewScreen), for: .touchUpInside)
              }
              
              @IBAction func showNewScreen(_ sender: UIButton) {
              //@objc func showNewScreen(_ sender: UIButton) {
                  let secondVC = SecondViewController()
                  navigationController?.pushViewController(secondVC, animated: true)
              }
              
              override func viewWillAppear(_ animated: Bool) {
                  super.viewWillAppear(animated)
                  print("🟢 viewWillAppear - chamado antes da view aparecer.")
              }
              
              override func viewWillLayoutSubviews() {
                  super.viewWillLayoutSubviews()
                  print("📐 viewWillLayoutSubviews - antes do Auto Layout ajustar as views")
              }
              
              override func viewDidLayoutSubviews() {
                  super.viewDidLayoutSubviews()
                  print("📏 viewDidLayoutSubviews - depois do Auto Layout ajustar as views.")
              }
              
              override func viewDidAppear(_ animated: Bool) {
                  super.viewDidAppear(animated)
                  print("✅ viewDidAppear - a view apareceu na tela.")
                  adjustLayoutForOrientation()
              }
              
              override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
                  super.viewWillTransition(to: size, with: coordinator)
                  print("🔄 viewWillTransition - mudança de orientação detectada.")
                  
                  coordinator.animate(alongsideTransition: { _ in
                      self.adjustLayoutForOrientation()
                  })
              }
              
              private func traitDidChange(_ previousTraitCollection: UITraitCollection?) {
                  print("🌗 Mudança de trait detectada — ex: modo claro/escuro mudou.")
                  
                  if traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle {
                      print("➡️ Modo claro/escuro foi alterado.")
                  }
              }
              
              /*
               override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
               super.traitCollectionDidChange(previousTraitCollection)
               
               if #available(iOS 17.0, *) {
               // Ignora - tratado via UITraitChangeObservable
               } else {
               print("🌗 traiCollectionDidChange - (iOS <17) modo claro/escuro ou outra trait mudou")
               }
               }
               */
              
              override func viewWillDisappear(_ animated: Bool) {
                  super.viewWillDisappear(animated)
                  print("🟠 viewWillDisappear - antes da view sumir.")
              }
              
              override func viewDidDisappear(_ animated: Bool) {
                  super.viewDidDisappear(animated)
                  print(("🔴 viewDidDisappear - depois que a viu sumiu."))
              }
              
              override func didReceiveMemoryWarning() {
                  super.didReceiveMemoryWarning()
                  print("⚠️ didReceiveMemoryWarning - app com pouca memória.")
              }
              
            
              
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
               }
               }*/
              
              func fetchGreeting() {
                  if let greeting = UserService.shared.getGreeting() {
                      DispatchQueue.main.async {
                          self.labelCat.text = greeting
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
                          self.labelCat.text = cat.data.first
                      }
                  }
              }
              
              func chameLabelModal() {
                  let alertController = UIAlertController(title: "Opa!", message: "Você está no modal de um alert!", preferredStyle: .alert)
                  let action = UIAlertAction(title: "OK", style: .default) { _ in
                      print("O usuário clicou no OK.")
                  }
                  alertController.addAction(action)
                  present(alertController, animated: true)
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
              
              @IBAction func modalButton(_ sender: Any) {
                  let storyboard = UIStoryboard(name: "Main", bundle: nil)
                  //let modalVC = LabelModalViewController()
                  if let modalVC = storyboard.instantiateViewController(withIdentifier: "LabelModalViewController") as? LabelModalViewController {
                      modalVC.modalPresentationStyle = .formSheet // ou .pageSheet, .fullScreen
                      present(modalVC, animated: true)
                  }  else {
                      print("❌ Não foi possível encontrar a LabelModalViewController no storyboard.")
                  }
              }
              //Ao clicar no botão "vireButton", o modal será exibido com todas as labels geradas dinamicamente pela LabelService.
              
              func adjustLayoutForOrientation() {
                  guard let orientation = UIApplication.shared.connectedScenes
                      .compactMap({ $0 as? UIWindowScene })
                      .first?.interfaceOrientation else {
                      return
                  }
                  
                  let isLandscape = orientation.isLandscape
                  
                  image.isHidden = isLandscape
              }
          }
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
