//
//  ViewController.swift
//  social_Media_ThirdProject
//
//  Created by ana on 22/07/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var galery: UIButton!
    @IBOutlet weak var photos: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemIndigo
        
        galery.layer.cornerRadius = 15
        photos.layer.cornerRadius = 15
        
    }
}
