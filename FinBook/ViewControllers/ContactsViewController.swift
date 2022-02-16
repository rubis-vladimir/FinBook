//
//  ContactsViewController.swift
//  FinBook
//
//  Created by Владимир Рубис on 16.01.2022.
//

import UIKit

class ContactsViewController: UICollectionViewController {
    
    //MARK: - Properties
    private let startLabel = UILabel()
    
    private let developers = Bundle.main.decode([Developer].self, from: "developers.json")
    
    //REFACTORING!!!!!!
    private let sectionInfoIndexPath: IndexPath = [1, 0]
    private var defaultIndexPath: IndexPath {
        [0, developers.count + 1]
    }
    private lazy var selectedIndexPath: IndexPath = defaultIndexPath
    private var isSelected: Bool = false
    private var itemsPerRow: CGFloat = 1
    private let paddingSection: CGFloat = 20
    
    // MARK: - Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
    }
    
    // MARK: - UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int { 2 }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        section == 1 ? 1 : developers.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let developer = collectionView.indexPathsForSelectedItems!.isEmpty ? developers[indexPath.row] : developers[selectedIndexPath.row]
        
        switch indexPath.section {
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContactInfoCell.reuseId, for: indexPath) as! ContactInfoCell
            cell.configure(with: developer)
            cell.updateCell(isSelected)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContactPhotoCell.reuseId, for: indexPath) as! ContactPhotoCell
            cell.configure(with: developer)
            return cell
        }
    }
    
    // MARK: - UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if selectedIndexPath == indexPath {
                isSelected = false
                collectionView.deselectItem(at: indexPath, animated: true)
                selectedIndexPath = defaultIndexPath
            } else {
                isSelected = true
                selectedIndexPath = indexPath
            }
            collectionView.reloadItems(at: [sectionInfoIndexPath])
        }
    }
    
    // MARK: - Private func
    private func setupElements() {
        collectionView.register(ContactInfoCell.self, forCellWithReuseIdentifier: ContactInfoCell.reuseId)
        collectionView.register(ContactPhotoCell.self, forCellWithReuseIdentifier: ContactPhotoCell.reuseId)
        
//        startLabel.setupDefaultLabel(view: self.collectionView.sec,
//                                     title: "Для отображения контактной информации разработчика нажмите на соответствующую карточку")
        collectionView.backgroundColor = UIColor.Palette.background
    }
}

// MARK: - UICollectionViewFlowLayout
extension ContactsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: paddingSection / 2, left: paddingSection, bottom: paddingSection / 2, right: paddingSection)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 1:
            itemsPerRow = 1
        default:
            itemsPerRow = 2
            
            // change item transporency when selecting
            guard let cell = collectionView.cellForItem(at: indexPath) as? ContactPhotoCell else {
                return calculateSizeForItem(itemPerRow: itemsPerRow)
            }
            cell.photoView.alpha = collectionView.indexPathsForSelectedItems?.first == indexPath ||
            collectionView.indexPathsForSelectedItems?.isEmpty == true ? 1 : 0.3
        }
        return calculateSizeForItem(itemPerRow: itemsPerRow)
    }
    
    // the function calculates the dimensions of the item
    private func calculateSizeForItem(itemPerRow: CGFloat) -> CGSize {
        let paddingWidth = paddingSection * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        
        let heightStackInItem: CGFloat = 65
        let paddingItem: CGFloat = paddingSection / 2
        let numberOfDeveloperLink: CGFloat = 4
        
        var heightPerItem: CGFloat = widthPerItem + heightStackInItem - 5
        
        if itemPerRow == 1 {
            heightPerItem = heightStackInItem * numberOfDeveloperLink + paddingItem * (numberOfDeveloperLink + 1)
        }
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
}

extension ContactsViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        UIApplication.shared.open(URL)
        return false
    }
}
