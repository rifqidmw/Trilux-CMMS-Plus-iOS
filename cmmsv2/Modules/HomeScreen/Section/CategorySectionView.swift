//
//  CategorySectionView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 07/01/24.
//

import UIKit

class CategorySectionView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var data: [CategoryModel] = categoryData
    weak var delegate: HomeScreenCategoryDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        let view = loadNib()
        view.frame = self.bounds
        self.addSubview(view)
        setupCollectionView()
    }
    
}

extension CategorySectionView {
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryCardCVC.nib, forCellWithReuseIdentifier: CategoryCardCVC.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.itemSize = CGSize(width: 72, height: 128)
        collectionView.collectionViewLayout = layout
    }
    
}

extension CategorySectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCardCVC.identifier, for: indexPath) as? CategoryCardCVC
        else {
            return UICollectionViewCell()
        }
        
        cell.setupCell(data: data[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate = self.delegate else { return }
        switch indexPath.row {
        case 0:
            delegate.didTapAllCategory()
        case 1:
            delegate.didTapAsset()
        case 2:
            delegate.didTapComplaint()
        case 3:
            delegate.didTapWorkSheet()
        case 4:
            delegate.didTapHistory()
        case 5:
            delegate.didTapDelayCorrective()
        case 6:
            delegate.didTapLogBook()
        case 7:
            delegate.didTapPreventiveCalendar()
        default: break
        }
    }
    
}