import UIKit

class ProgrammaticUIView: UIView {
        
    var shift: Shift?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder){
        nil
    }

    func setupViews() {
        setupSubviews()
        setupConstraints()
        setupLayout()
    }
    
    func setupSubviews() {
        addSubview(UIView())
    }
    
    func setupConstraints() {
        safeAreaLayoutGuide.topAnchor.constraint(equalTo: topAnchor).isActive = true
        safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true        
    }
    
    func setupLayout() {
        
    }

}
