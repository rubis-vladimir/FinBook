//
//  ContactsViewController.swift
//  FinBook
//
//  Created by Владимир Рубис on 16.01.2022.
//

import UIKit

// MARK: Класс описывает экран контактов
class ContactsViewController: UICollectionViewController {
    
    //MARK: - Properties
    private let dataFetcher = DataFetcherService()
    
    private let paddingSection: CGFloat = 20
    
    private var isSelected: Bool = false
    private var defaultIndexPath: IndexPath {
        [0, developers.count + 1]
    }
    private var developers: [Developer] {
        var developers: [Developer] = []
        dataFetcher.fetchDevelopers { (dev) in
            developers = dev ?? []
        }
        return developers
    }
    
    private lazy var selectedIndexPath: IndexPath = defaultIndexPath
    
    // MARK: - Override funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
    }
    
    // MARK: - Private funcs
    private func setupElements() {
        collectionView.register(ContactInfoCell.self, forCellWithReuseIdentifier: ContactInfoCell.reuseId)
        collectionView.register(ContactPhotoCell.self, forCellWithReuseIdentifier: ContactPhotoCell.reuseId)
        collectionView.backgroundColor = Palette.background
    }
    
    // MARK: - UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int { 2 }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        section == 1 ? 1 : developers.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let developer = collectionView.indexPathsForSelectedItems!.isEmpty ? developers[indexPath.row] : developers[selectedIndexPath.row]
        
        switch indexPath.section {
            /// для окна контактной информации
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContactInfoCell.reuseId, for: indexPath) as! ContactInfoCell
            cell.configure(with: developer)
            cell.updateCell(isSelected)
            return cell
            
            /// для иконки разработчика
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContactPhotoCell.reuseId, for: indexPath) as! ContactPhotoCell
            cell.configure(with: developer)
            return cell
        }
    }
    
    // MARK: - UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /// при нажатии на иконку разработчика
        if indexPath.section == 0 {
            
            /// Обновляем элементы, если:
            /// иконка `была не выделена` - выделяется
            /// и отображается окно контактной информации
            /// иконка `была выделена` - снимается выделение
            /// и скрывается окно контактной информации
            if selectedIndexPath != indexPath {
                isSelected = true
                selectedIndexPath = indexPath
            } else {
                isSelected = false
                collectionView.deselectItem(at: indexPath, animated: true)
                selectedIndexPath = defaultIndexPath
            }
            collectionView.reloadItems(at: [[1, 0]])
        }
    }
}


// MARK: - UICollectionViewFlowLayout
extension ContactsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: paddingSection / 2, left: paddingSection, bottom: paddingSection / 2, right: paddingSection)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var itemsPerRow: CGFloat = 2
        
        switch indexPath.section {
            /// для окна контактной информации
        case 1:
            itemsPerRow = 1
            
            /// для иконки разработчика
        default:
            guard let cell = collectionView.cellForItem(at: indexPath) as? ContactPhotoCell else {
                break }
            
            /// изменяем прозрачность иконки разработчика
            /// при нажатии на иконку другого разработчика
            cell.photoView.alpha = collectionView.indexPathsForSelectedItems?.first == indexPath ||
            collectionView.indexPathsForSelectedItems?.isEmpty == true ? 1 : 0.3
        }
        return calculateSizeForItem(itemPerRow: itemsPerRow)
    }
    
    /// Рассчитывает ширину и высоту `Item`
    ///  - Parameters:
    ///     - itemPerRow: количество `Item` на строке
    ///  - Returns: размеры
    private func calculateSizeForItem(itemPerRow: CGFloat) -> CGSize {
        let heightLink: CGFloat = 65
        let numberOfLinks: CGFloat = 4
        
        let paddingWidth = paddingSection * (itemPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemPerRow
        
        var heightPerItem: CGFloat = widthPerItem + heightLink
        if itemPerRow == 1 {
            heightPerItem = heightLink * numberOfLinks + paddingSection / 2 * (numberOfLinks + 1)
        }
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
}


// MARK: - UITextViewDelegate. Link Navigation
extension ContactsViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
}
