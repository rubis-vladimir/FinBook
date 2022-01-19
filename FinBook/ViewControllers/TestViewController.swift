//
//  TestViewController.swift
//  FinBook
//
//  Created by Владимир Рубис on 16.01.2022.
//

import UIKit

class TestViewController: UICollectionViewController {
    
    var selectedIndex: Int = 2
    var selectedCell = [IndexPath]()
    
    var itemsPerRow: CGFloat = 2
    let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    let developers = Bundle.main.decode([Developer].self, from: "developers.json")
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .orange
        setupCollectionView()
        self.collectionView.allowsMultipleSelection = false
    }
    
    func setupCollectionView() {

//        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        collectionView.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9921568627, alpha: 1)
//        view.addSubview(collectionView)
        
        collectionView.register(TestCollectionViewCell.self, forCellWithReuseIdentifier: TestCollectionViewCell.reuseId)
        collectionView.register(Test2CollectionViewCell.self, forCellWithReuseIdentifier: Test2CollectionViewCell.reuseId)
        
//        collectionView.delegate = self
//        collectionView.dataSource = self
    }
                
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        developers.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        switch collectionView.indexPathsForSelectedItems?.first {
//        case .some(indexPath):
//
//
//        default:
//
//
//        }
//        let cell: TestCollectionViewCell
//        let cell2: Test2CollectionViewCell
        
        let developer = developers[indexPath.row]
        print(selectedIndex)
        if selectedIndex == indexPath.row {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TestCollectionViewCell.reuseId, for: indexPath) as! TestCollectionViewCell
            cell.configure(with: developer)
            cell.backgroundColor = .gray
            return cell
        } else {
         let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: Test2CollectionViewCell.reuseId, for: indexPath) as! Test2CollectionViewCell
            
            cell2.configure(with: developer)
            return cell2
        }
        
        
        
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndex != 2 {
        selectedIndex = 2
            collectionView.reloadItems(at: selectedCell)
            selectedCell.removeAll()
        }
        selectedCell.append(indexPath)
        print(selectedCell)
        selectedIndex = collectionView.indexPathsForSelectedItems?.first?.row ?? 2
        selectedCell.append(indexPath)
        collectionView.performBatchUpdates(nil, completion: nil)
        collectionView.reloadItems(at: [indexPath])
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath)!
        print("323")
//        if selectedCell.contains(indexPath) {
//            selectedCell.remove(at: selectedCell.firstIndex(of: indexPath)!)
//            selectedIndex = 2
//            collectionView.reloadItems(at: [indexPath])
//        }
    }
}


extension TestViewController: UICollectionViewDelegateFlowLayout {

    func calculateSizeForItem(itemPerRow: CGFloat) -> CGSize {
        let paddingWidth = sectionInserts.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {


        switch collectionView.indexPathsForSelectedItems?.first {
        case .some(indexPath):
            itemsPerRow = 1
            return calculateSizeForItem(itemPerRow: itemsPerRow)
        default:
            itemsPerRow = 2
            return calculateSizeForItem(itemPerRow: itemsPerRow)
        }


    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
}
