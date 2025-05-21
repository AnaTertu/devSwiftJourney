//
//  ViewController.swift
//  guessTheFlag
//
//  Created by ana on 21/05/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries: [String] = [String]()
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries.append(contentsOf: ["Brasil", "Estonia", "France", "Germany", "Ireland", "Italy", "Monaco",  "Nigeria", "Spain", "Uk", "Ukraine", "Usa"])
        //countries += ["Brasil", "Estonia", "France", "Germany", "Ireland", "Italy", "Monaco",  "Nigeria", "Spain", "Uk", "Ukraine", "Usa"]
        
        button1.layer.borderWidth = 2
        button2.layer.borderWidth = 2
        button3.layer.borderWidth = 2
        
        button1.layer.borderColor = UIColor.orange.cgColor
        button2.layer.borderColor = UIColor.orange.cgColor
        button3.layer.borderColor = UIColor.orange.cgColor
        
        askQuestion()
    }
    
    func askQuestion() {
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
    }


}

