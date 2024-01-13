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
        switch indexPath.row {
        case 0:
            self.delegate?.didTapAllCategory()
        case 1:
            self.delegate?.didTapAsset()
        case 2:
            self.delegate?.didTapComplaint()
        case 3:
            self.delegate?.didTapWorkSheet()
        case 4:
            self.delegate?.didTapPreventiveMaintenance()
        default: break
        }
    }
    
}
