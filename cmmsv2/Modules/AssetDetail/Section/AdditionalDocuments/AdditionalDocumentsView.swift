//
//  AdditionalDocumentsView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 01/05/24.
//

import UIKit
import XLPagerTabStrip

class AdditionalDocumentsView: BaseViewController, IndicatorInfoProvider {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var data: [AdditionalDocument] = documentData
    
    override func didLoad() {
        super.didLoad()
        self.setupCollectionView()
    }
    
    override func willAppear() {
        super.willAppear()
        self.setupLayout(height: 1170)
    }
    
    func indicatorInfo(for pagerTabStripController: XLPagerTabStrip.PagerTabStripViewController) -> XLPagerTabStrip.IndicatorInfo {
        return IndicatorInfo(title: "Dokumen Tambahan")
    }
    
}

extension AdditionalDocumentsView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(AdditionDocumentCVC.nib, forCellWithReuseIdentifier: AdditionDocumentCVC.identifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdditionDocumentCVC.identifier, for: indexPath) as? AdditionDocumentCVC
        else {
            return UICollectionViewCell()
        }
        
        cell.setupCell(data: self.data[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 158, height: 174)
    }
}
