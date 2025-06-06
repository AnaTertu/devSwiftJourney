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
    var correctAnswer = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //countries.append(contentsOf: ["Brasil", "Estonia", "France", "Germany", "Ireland", "Italy", "Monaco",  "Nigeria", "Spain", "Uk", "Ukraine", "Usa"])
        countries += ["Brasil", "Estonia", "France", "Germany", "Ireland", "Italy", "Monaco",  "Nigeria", "Spain", "UK", "Ukraine", "USA"]
        
        button1.layer.borderWidth = 6
        button2.layer.borderWidth = 6
        button3.layer.borderWidth = 6
        
        button1.layer.borderColor = UIColor.darkGray.cgColor
        button2.layer.borderColor = UIColor.darkGray.cgColor
        button3.layer.borderColor = UIColor.darkGray.cgColor
        
        askQuestion()
    }
        
    func askQuestion(action: UIAlertAction? = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased()
        
        
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }
        
        let ac = UIAlertController(title: title, message: "Your scores is \(score)", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        present(ac, animated: true)
        
    }
    

}

