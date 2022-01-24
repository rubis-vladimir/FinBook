//
//  ContactsViewController.swift
//  FinBook
//
//  Created by Владимир Рубис on 16.01.2022.
//

import UIKit

class ContactsViewController: UICollectionViewController {
    
    var selectedIndex: IndexPath = [0, 2]
    var isSelected: Bool = false
    var itemsPerRow: CGFloat = 1
    let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
    
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
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int { 2 }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 1 ? 1 : developers.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(indexPath)
        let developer = selectedIndex == [0, 2] ? developers[indexPath.row] : developers[selectedIndex.row]
        
        print(developer.surname)
        switch indexPath.section {
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContactInfoCell.reuseId, for: indexPath) as! ContactInfoCell
            cell.configure(with: developer)
            cell.isHidden = isSelected ? false : true
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContactPhotoCell.reuseId, for: indexPath) as! ContactPhotoCell
            cell.configure(with: developer)
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if selectedIndex == indexPath {
                isSelected = false
                collectionView.deselectItem(at: selectedIndex, animated: true)
                collectionView.reloadItems(at: [[1, 0]])
                selectedIndex = [0, 2]
            } else {
                isSelected = true
                collectionView.deselectItem(at: selectedIndex, animated: true)
                selectedIndex = indexPath
                collectionView.reloadItems(at: [[1, 0]])
            }
        }
    }
}

extension ContactsViewController: UICollectionViewDelegateFlowLayout {
    
    func calculateSizeForItem(itemPerRow: CGFloat) -> CGSize {
        let paddingWidth = sectionInserts.top * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        
        let widthPerItem = availableWidth / itemsPerRow
        
        var heightPerItem: CGFloat = widthPerItem + 75
        
        if itemPerRow == 1 {
            heightPerItem =
//            ContactInfoCell.heightLink * 3 + 45
            self.view.frame.height - heightPerItem - paddingWidth
        }
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 1:
            itemsPerRow = 1
        default:
            itemsPerRow = 2
            
            guard let cell = collectionView.cellForItem(at: indexPath) as? ContactPhotoCell else {
                return calculateSizeForItem(itemPerRow: itemsPerRow)
            }
            cell.photoView.alpha = collectionView.indexPathsForSelectedItems?.first == indexPath ||
            collectionView.indexPathsForSelectedItems?.isEmpty == true ? 1 : 0.3
        }
        return calculateSizeForItem(itemPerRow: itemsPerRow)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return sectionInserts.top
//    }
    
}
