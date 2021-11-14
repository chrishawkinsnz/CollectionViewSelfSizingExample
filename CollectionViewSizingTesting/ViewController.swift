//
//  ViewController.swift
//  CollectionViewSizingTesting
//
//  Created by chawkins on 15/11/21.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    private var items: Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = .init(width: 100, height: 100)
    }
    
    @objc
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items
    }
    
    @objc
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExampleCell", for: indexPath) as! ExampleCell
        if indexPath.row == (items - 1) {
            cell.label.text = "Load more"
            cell.contentView.backgroundColor = .green
        }
        else {
            cell.label.text = "\(indexPath.row)"
            cell.contentView.backgroundColor = .purple
        }
        return cell
    }
    
    @objc
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("[TM] Calculating size for cell \(indexPath.row)")
        return CGSize(width: 100, height: 100)
    }
    
    @objc
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {//
        print("[TM] 🟩 Loading cells \(items) - \(items + 10)")
        
        collectionView.performBatchUpdates {
            let newIndexPaths = (self.items..<(self.items+10)).map { IndexPath(item: $0, section: 0) }
            self.items += 10
            collectionView.reloadItems(at: [indexPath])
            collectionView.insertItems(at: newIndexPaths)
        }
    }
}



class ExampleCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
}

