//
//  CorrectiveHoldListView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 14/03/24.
//

import UIKit

class DelayCorrectiveListView: BaseViewController {
    
    @IBOutlet weak var customNavigationView: CustomNavigationView!
    @IBOutlet weak var searchButton: GeneralButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: DelayCorrectiveListPresenter?
    var data: [DelayCorrectiveListEntity] = delayCorrectiveDataList
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
    }
    
}

extension DelayCorrectiveListView {
    
    private func setupBody() {
        setupView()
        setupAction()
        setupCollectionView()
    }
    
    private func setupView() {
        customNavigationView.configure(plainTitle: "Korektif Tertunda", type: .plain)
        searchButton.configure(type: .searchbutton)
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
        collectionView.register(DelayCorrectiveCVC.nib, forCellWithReuseIdentifier: DelayCorrectiveCVC.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.itemSize = CGSize(width: collectionView.frame.size.width, height: 200)
        collectionView.collectionViewLayout = layout
    }
    
}

extension DelayCorrectiveListView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DelayCorrectiveCVC.identifier, for: indexPath) as? DelayCorrectiveCVC
        else {
            return UICollectionViewCell()
        }
        
        cell.setupCell(data: data[indexPath.row])
        
        return cell
    }
    
}
