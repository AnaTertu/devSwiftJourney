//
//  ViewController.swift
//  collectionView
//
//  Created by ana on 24/04/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private let categories: [String] = ["Animals", "Food", "Travel", "Nature", "Sports", "Animals", "Food", "Travel", "Nature", "Sports", "Animals", "Food", "Travel", "Nature", "Sports"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self 
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCategoryCell", for: indexPath) as! CategoryCollectionViewCell
        
        cell.background.backgroundColor = UIColor.systemBlue
        cell.title.text = categories[indexPath.row]
        
        return cell
    }
    
}

