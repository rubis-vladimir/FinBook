//
//  TestViewController.swift
//  FinBook
//
//  Created by Владимир Рубис on 16.01.2022.
//

import UIKit

class ContactsViewController: UICollectionViewController {
    
    var selectedIndex: IndexPath = [0, 2]
    var isChanged: Bool = false
    var itemsPerRow: CGFloat = 1
    let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    var developers = Bundle.main.decode([Developer].self, from: "developers.json")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ColorManager.shared.setThemeColors(mainElement: collectionView, secondaryElement: navigationController?.navigationBar)
    }
    
    func setupCollectionView() {
        collectionView.register(ContactInfoCell.self, forCellWithReuseIdentifier: ContactInfoCell.reuseId)
        collectionView.register(ContactPhotoCell.self, forCellWithReuseIdentifier: ContactPhotoCell.reuseId)
        collectionView.allowsMultipleSelection = false
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        developers.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let developer = developers[indexPath.row]
        
        if isChanged {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContactInfoCell.reuseId, for: indexPath) as! ContactInfoCell
            cell.configure(with: developer)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContactPhotoCell.reuseId, for: indexPath) as! ContactPhotoCell
            cell.configure(with: developer)
            
            if selectedIndex == indexPath {
                cell.photoView.alpha = 1
            }
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndex == indexPath {
            isChanged = false
            collectionView.deselectItem(at: selectedIndex, animated: true)
            collectionView.reloadItems(at: [selectedIndex])
            selectedIndex = [0, 2]
        } else {
            if selectedIndex != [0, 2] {
                isChanged = false
                collectionView.deselectItem(at: selectedIndex, animated: true)
                collectionView.reloadItems(at: [selectedIndex])
            }
            isChanged = true
            collectionView.reloadItems(at: [indexPath])
            selectedIndex = indexPath
        }
    }
}

extension ContactsViewController: UICollectionViewDelegateFlowLayout {
    
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
            guard let cell =  collectionView.cellForItem(at: indexPath) as? ContactPhotoCell
            else {
                return calculateSizeForItem(itemPerRow: itemsPerRow)
            }
            cell.photoView.alpha = collectionView.indexPathsForSelectedItems?.isEmpty ?? true ? 1 : 0.3
            return calculateSizeForItem(itemPerRow: itemsPerRow)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.top
    }
}
