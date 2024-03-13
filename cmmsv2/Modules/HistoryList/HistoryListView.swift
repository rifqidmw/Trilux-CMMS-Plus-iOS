//
//  HistoryListView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/03/24.
//

import UIKit

class HistoryListView: BaseViewController {
    
    @IBOutlet weak var customNavigationView: CustomNavigationView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var actionBarView: ActionBarView!
    
    var presenter: HistoryListPresenter?
    var data: [HistoryListEntity] = historyDataList
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
    }
    
}

extension HistoryListView {
    
    private func setupBody() {
        setupView()
        setupAction()
        setupCollectionView()
    }
    
    private func setupView() {
        customNavigationView.configure(plainTitle: "Riwayat Pengaduan", type: .plain)
        actionBarView.configure(fourthIcon: "ic_setting", fourthTitle: "Kondisi")
    }
    
    private func setupAction() {
        customNavigationView.arrowLeftBackButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let navigation = self.navigationController
                else { return }
                navigation.popViewController(animated: true)
            }
            .store(in: &anyCancellable)
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HistoryCVC.nib, forCellWithReuseIdentifier: HistoryCVC.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.itemSize = CGSize(width: collectionView.frame.size.width, height: 130)
        collectionView.collectionViewLayout = layout
    }
    
}

extension HistoryListView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HistoryCVC.identifier, for: indexPath) as? HistoryCVC
        else {
            return UICollectionViewCell()
        }
        
        cell.setupCell(data: data[indexPath.row])
        
        return cell
    }
    
}
