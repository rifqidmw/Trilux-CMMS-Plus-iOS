//
//  SupportingDocumentationView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/02/24.
//

import UIKit

class SupportingDocumentationView: UIView {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var customHeaderView: CustomHeaderView!
    @IBOutlet weak var collectionView: UICollectionView!
    
//    var type: WorkSheetOnsitePreventiveDetailType?
    var data: [Media] = []
    
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
        configureSharedComponent()
        setupCollectionView()
    }
    
}

extension SupportingDocumentationView {
    
    private func configureSharedComponent() {
        containerView.makeCornerRadius(8)
        containerView.addShadow(4, opacity: 0.2)
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(EvidenceEquipmentCVC.nib, forCellWithReuseIdentifier: EvidenceEquipmentCVC.identifier)
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 72, height: collectionView.frame.height)
        collectionView.collectionViewLayout = layout
    }
//    
//    func configure(data: [Media], type: WorkSheetOnsitePreventiveDetailType) {
//        self.type = type
//        self.data = data
//        customHeaderView.configure(icon: "ic_image", title: "Foto Pendukung", count: 9, type: type == .seeOnly ? .collapsibleWithCount : .plain)
//    }
//    
}

extension SupportingDocumentationView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EvidenceEquipmentCVC.identifier, for: indexPath) as? EvidenceEquipmentCVC
        else {
            return UICollectionViewCell()
        }
        
        cell.setupCell(data: data[indexPath.row])
        
        return cell
    }
    
}
