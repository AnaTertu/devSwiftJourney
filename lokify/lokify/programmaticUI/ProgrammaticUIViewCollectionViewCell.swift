import UIKit

class ProgrammaticUIViewCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String { String(describing: Self.self)}
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .dayText
        return label
    }()
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "sunnyDay")
        image.setContentHuggingPriority(.required, for: .vertical)
        image.setContentHuggingPriority(.required, for: .horizontal)
        image.setContentCompressionResistancePriority(.required, for: .horizontal)
        return image
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Escreva seu nome"
        return textField
    }()
    
    lazy var nameButton: UIButton = {
        let button = UIButton(type: <#T##UIButton.ButtonType#>)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Enviar nome", for: .normal)
        addSubview(nameButton)
        return nameButton
    }()
    
    lazy var changeButton: UIButton = {
        let button = UIButton(type: <#T##UIButton.ButtonType#>)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Change", for: .normal)
        addSubview(changeButton)
        return button
    }()
    
    var shift: Shift?
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    func setupViews(){
        setupSubviews()
        setupConstraints()
        setupLayout()
    }
    
    func setupSubviews() {
        addSubview(image)
        addSubview(textField)
        addSubview(changeButton)
        addSubview(nameButton)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            label.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 40),
            label.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -40),
            
            image.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            image.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            image.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            image.heightAnchor.constraint(equalToConstant: 186),
            image.widthAnchor.constraint(equalToConstant: 186),
            
            textField.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            textField.heightAnchor.constraint(equalToConstant: 40),
            
            nameButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            nameButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            changeButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            changeButton.leadingAnchor.constraint(equalTo: nameButton.leadingAnchor, constant: 10),
            changeButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 20)
        ])
        
    }
    
    func setupLayout() {
        
        guard let shift else { return }
        
        contentView.backgroundColor = UIColor(named:  shift == .day ? "dayBackground" : "nightBackground")
        
    }
    
}
