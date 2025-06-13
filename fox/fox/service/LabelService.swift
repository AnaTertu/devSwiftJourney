import Foundation
import UIKit

class LabelService {
    
    var view: UIView!  // 🔸 Esta view será passada de fora
    var labels: [UILabel] = []
    
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
            ("Magenta", .magenta),
            ("White", .white),
            ("Black", .black),
            ("DarkGray", .darkGray),
            ("Gray", .gray),
            ("LightGray", .lightGray)
        ]
        
        for (text, color) in textsAndColors {
            let labelA = createLabel(text: text, backgroundColor: color)
            labels.append(labelA)
            view.addSubview(labelA)
        }
        
    }
    
    func setupLabelConstraints() {
        guard labels.count >= 14 else { return }

        let label0 = labels[0]
        let label1 = labels[1]
        let label2 = labels[2]
        let label3 = labels[3]
        let label4 = labels[4]
        let label5 = labels[5]
        let label6 = labels[6]
        let label7 = labels[7]
        let label8 = labels[8]
        let label9 = labels[9]
        let label10 = labels[10]
        let label11 = labels[11]
        let label12 = labels[12]
        let label13 = labels[13]
        
        
        label0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        
        let viewsLabels: [String: UIView] = [
            "label1": label1, "label2": label2,
            "label3": label3, "label4": label4,
            "label5": label5
        ]
        
        for key in viewsLabels.keys {
            view.addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat: "H:|[\(key)]|",
                options: [], metrics: nil, views: viewsLabels
            ))
        }
        
        let metrics = ["labelHeight": 25]
        
        
        view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:  "V:|[label1(labelHeight@90)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]-(>=10)-|",
            options: [], metrics: metrics, views: viewsLabels
        ))
        
        // maior prioridade todos são default @1000 - menor prioridade @1 - todas são levadas em consideração << @999 >>
        NSLayoutConstraint.activate([
            label0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            label0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            label6.topAnchor.constraint(equalTo: label5.bottomAnchor, constant: 20),
            label7.topAnchor.constraint(equalTo: label6.bottomAnchor, constant: 10),
            label8.topAnchor.constraint(equalTo: label7.bottomAnchor, constant: 10),
            label9.topAnchor.constraint(equalTo: label8.bottomAnchor),
            label10.topAnchor.constraint(equalTo: label9.bottomAnchor),
            
            label6.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            label6.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            label7.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            label7.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
        ])
        
        var previous: UILabel?
        
        for label in [label10, label11, label12, label13] {
            label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            label.heightAnchor.constraint(equalToConstant: 88).isActive = true
            
            if let previous = previous {
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
            }
            previous = label
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
    
}

