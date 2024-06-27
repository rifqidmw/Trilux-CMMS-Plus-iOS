//
//  LoadPreventiveView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 29/05/24.
//

import UIKit
import SkeletonView

class LoadPreventiveView: BaseViewController {
    
    @IBOutlet weak var customNavigationView: CustomNavigationView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var workButton: GeneralButton!
    @IBOutlet weak var emptyView: UIView!
    
    var data: [LoadPreventiveList] = []
    var presenter: LoadPreventivePresenter?
    var bottomSheet: AddPreventiveBottomSheet?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.validateUser()
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
                self.collectionView.hideSkeleton()
            }
            .store(in: &anyCancellable)
        
        presenter.$createPreventiveData
            .sink { [weak self] data in
                guard let self, let data else { return }
                self.hideLoadingPopup()
                if data.message == "Success" {
                    self.dismissBottomSheet()
                    self.fetchInitialData()
                    self.reloadCollectionViewWithAnimation()
                } else {
                    if let bottomSheet = self.bottomSheet {
                        bottomSheet.showAlert(title: "Peringatan", message: data.message)
                    }
                }
            }
            .store(in: &anyCancellable)
    }
    
    private func setupView() {
        customNavigationView.configure(toolbarTitle: "Kalender Preventif", type: .toolbar, actionTitle: "Tambah")
        workButton.configure(title: "Kerjakan")
        workButton.makeCornerRadius(8)
        workButton.addShadow(0.4)
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.collectionView.isSkeletonable = true
            self.collectionView.showAnimatedGradientSkeleton()
        }
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
                presenter.showBottomSheetAddPreventive(from: navigation, self)
            }
            .store(in: &anyCancellable)
        
        workButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let title = self.workButton.titleLabel.text,
                      let navigation = self.navigationController,
                      let data = presenter.data
                else { return }
                let workSheet = WorkSheetRequestEntity(id: data.idLK, action: title.lowercased())
                presenter.navigateToDetailWorkSheet(navigation, data: workSheet, type: .preventive)
            }
            .store(in: &anyCancellable)
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(LoadPreventiveCVC.nib, forCellWithReuseIdentifier: LoadPreventiveCVC.identifier)
    }
    
    func reloadCollectionViewWithAnimation() {
        UIView.transition(with: collectionView, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.collectionView.reloadData()
        }, completion: nil)
    }
    
}

extension LoadPreventiveView: SkeletonCollectionViewDelegate, SkeletonCollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, skeletonCellForItemAt indexPath: IndexPath) -> UICollectionViewCell? {
        return collectionView.dequeueReusableCell(withReuseIdentifier: LoadPreventiveCVC.identifier, for: indexPath)
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return LoadPreventiveCVC.identifier
    }
    
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
