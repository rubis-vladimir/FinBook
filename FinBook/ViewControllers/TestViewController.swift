//
//  TestViewController.swift
//  FinBook
//
//  Created by Владимир Рубис on 16.01.2022.
//

import UIKit

class TestViewController: UICollectionViewController {
    
    //    var selectedIndex: Int = 2
    var selectedIndex: IndexPath = [0, 2]
    //    var selectedCell = [IndexPath]()
    var isChanged: Bool = false
    
    var itemsPerRow: CGFloat = 1
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
        //        print(selectedIndex)
        if isChanged {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TestCollectionViewCell.reuseId, for: indexPath) as! TestCollectionViewCell
            cell.configure(with: developer)
            return cell
        } else {
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: Test2CollectionViewCell.reuseId, for: indexPath) as! Test2CollectionViewCell
            
            if selectedIndex == indexPath {
            cell2.photo.alpha = 1
            }
            //            if itemsPerRow == 2 {
//            cell2.photo.alpha =  ? 1 : 0.5
            //            }
            cell2.configure(with: developer)
            
            return cell2
        }
        
        //        [0, 1]
        //       == indexPath.row
        //        [0]
        //        != indexPath.row
        //        [0, 1]
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //   = 0, 1
        if selectedIndex == indexPath {
            isChanged = false
            collectionView.deselectItem(at: selectedIndex, animated: true)
            collectionView.reloadItems(at: [selectedIndex])
            selectedIndex = [0, 2]
            //            collectionView.performBatchUpdates(nil, completion: nil)
        } else {
            // ip = 0, 0
            if selectedIndex != [0, 2] {
                isChanged = false
                collectionView.deselectItem(at: selectedIndex, animated: true)
                collectionView.reloadItems(at: [selectedIndex])
                
            }
            
            isChanged = true
            collectionView.reloadItems(at: [indexPath])
            
            selectedIndex = indexPath
            //            collectionView.performBatchUpdates(nil, completion: nil)
        }
        //        selectedCell.append(indexPath)
        //
        //        selectedIndex = collectionView.indexPathsForSelectedItems?.first?.row ?? 2
        //
        //        selectedCell.append(indexPath)
        
        //        collectionView.reloadItems(at: [indexPath])
        
        //
        
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
        
        //        itemsPerRow = isChanged ? 1 : 2
        
        //        return calculateSizeForItem(itemPerRow: itemsPerRow)
        print(indexPath)
        switch collectionView.indexPathsForSelectedItems?.first {
        case .some(indexPath):
            itemsPerRow = 1
//            print(collectionView.indexPathsForSelectedItems)
            return calculateSizeForItem(itemPerRow: itemsPerRow)
        default:
            itemsPerRow = 2
//            print(collectionView.indexPathsForSelectedItems)
            guard let cell =  collectionView.cellForItem(at: indexPath) as? Test2CollectionViewCell else {
                return
                calculateSizeForItem(itemPerRow: itemsPerRow)}
//            if indexPath == collectionView.indexPathsForSelectedItems?.first {
            if !(collectionView.indexPathsForSelectedItems?.isEmpty ?? true) {
                cell.photo.alpha = 0.5 }
            else {
                cell.photo.alpha = 1
            }
            return calculateSizeForItem(itemPerRow: itemsPerRow)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.top
    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    //        return 500
    //    }
}
