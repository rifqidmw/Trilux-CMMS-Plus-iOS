//
//  LoadPreventiveView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 29/05/24.
//

import UIKit

class LoadPreventiveView: BaseViewController {
    
    @IBOutlet weak var customNavigationView: CustomNavigationView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var workButton: GeneralButton!
    @IBOutlet weak var emptyView: UIView!
    
    var data: [LoadPreventiveList] = []
    var presenter: LoadPreventivePresenter?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
    }
    
}

extension LoadPreventiveView {
    
    func setupBody() {
        fetchInitialData()
        bindingData()
        setupView()
        setupAction()
        setupCollectionView()
    }
    
    private func fetchInitialData() {
        guard let presenter else { return }
        presenter.fetchInitData()
    }
    
    private func bindingData() {
        guard let presenter else { return }
        presenter.$loadPreventiveData
            .sink { [weak self] data in
                guard let self,
                      let data,
                      let preventiveList = data.list
                else { return }
                
                if preventiveList.isEmpty {
                    self.collectionView.isHidden = true
                    self.emptyView.isHidden = false
                } else {
                    self.collectionView.isHidden = false
                    self.emptyView.isHidden = true
                }
                
                self.data = preventiveList
                self.collectionView.reloadData()
            }
            .store(in: &anyCancellable)
    }
    
    private func setupView() {
        customNavigationView.configure(plainTitle: "Kalender Preventif", type: .toolbar, actionTitle: "Tambah")
        workButton.configure(title: "Kerjakan")
        workButton.makeCornerRadius(8)
        workButton.addShadow(0.4)
    }
    
    private func setupAction() {
        guard let presenter else { return }
        customNavigationView.arrowLeftBackButton.gesture()
            .sink { [weak self] _ in
                guard let self, let navigation = self.navigationController else { return }
                navigation.popViewController(animated: true)
            }
            .store(in: &anyCancellable)
        
        customNavigationView.actionLabel.gesture()
            .sink { [weak self] _ in
                guard let self, let navigation = self.navigationController else { return }
                presenter.showBottomSheetAddPreventive(from: navigation)
            }
            .store(in: &anyCancellable)
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(LoadPreventiveCVC.nib, forCellWithReuseIdentifier: LoadPreventiveCVC.identifier)
    }
    
}

extension LoadPreventiveView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoadPreventiveCVC.identifier, for: indexPath) as? LoadPreventiveCVC
        else {
            return UICollectionViewCell()
        }
        
        cell.setupCell(data: self.data[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.1, height: 120)
    }
    
}
