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
    
    var data: [File] = []
    weak var parentView: AssetDetailView?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
    }
    
    override func willAppear() {
        super.willAppear()
        self.setupLayout(height: 1170)
    }
    
    func indicatorInfo(for pagerTabStripController: XLPagerTabStrip.PagerTabStripViewController) -> XLPagerTabStrip.IndicatorInfo {
        return IndicatorInfo(title: "Dokumen Tambahan")
    }
    
    private func setupBody() {
        bindingData()
        setupCollectionView()
    }
    
    private func bindingData() {
        guard let view = self.parentView else { return }
        view.$filesData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                guard let self else { return }
                self.data = data
                self.collectionView.reloadData()
            }
            .store(in: &anyCancellable)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedFile = self.data[indexPath.row]
        if selectedFile.url == "" {
            self.showAlert(title: "Dokumen tidak ditemukan!")
        }
    }
    
}
