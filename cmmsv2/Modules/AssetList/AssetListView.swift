//
//  AssetListView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/02/24.
//

import UIKit
import SkeletonView

class AssetListView: BaseViewController {
    
    @IBOutlet weak var customNavigationView: CustomNavigationView!
    @IBOutlet weak var searchButton: GeneralButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var customActionBar: ActionBarView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var presenter: AssetListPresenter?
    var data: [Equipment] = []
    
    override func didLoad() {
        super.didLoad()
        setupBody()
    }
    
    override func willAppear() {
        super.willAppear()
        self.fetchInitData()
    }
    
}

extension AssetListView {
    
    private func setupBody() {
        fetchInitData()
        bindingData()
        setupView()
        setupAction()
        setupDelegate()
        setupCollectionView()
    }
    
    private func fetchInitData() {
        guard let presenter else { return }
        presenter.fetchInitData()
    }
    
    private func bindingData() {
        guard let presenter else { return }
        presenter.$equipmentData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                guard let self,
                      let equipment = data,
                      let reff = equipment.reff,
                      let count = reff.totalItem
                else { return }
                self.countLabel.text = "Berhasil menemukan \(count) Item"
            }
            .store(in: &anyCancellable)
        
        presenter.$equipment
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                guard let self
                else {
                    self?.showSpinner(false)
                    return
                }
                self.data = data
                self.collectionView.reloadData()
                self.showSpinner(false)
                self.hideSkeletonAnimation()
            }
            .store(in: &anyCancellable)
    }
    
    private func setupView() {
        customNavigationView.configure(plainTitle: "Aset", type: .plain)
        searchButton.configure(type: .searchbutton)
        customActionBar.configure(firstIcon: "ic_installation", firstTitle: "Instalasi", secondIcon: "ic_setting", secondTitle: "Kondisi", thirdIcon: "ic_structural", thirdTitle: "Kategori", fourthIcon: "ic_arrow_up_down", fourthTitle: "Urutkan")
        self.countLabel.isSkeletonable = true
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.setupSkeleton()
        }
        
    }
    
    private func setupDelegate() {
        self.customActionBar.delegate = self
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
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(AssetCVC.nib, forCellWithReuseIdentifier: AssetCVC.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 24, right: 0)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: collectionView.frame.size.width, height: 120)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        collectionView.collectionViewLayout = layout
        collectionView.isSkeletonable = true
        collectionView.showAnimatedGradientSkeleton()
    }
    
    private func setupSkeleton() {
        [self.collectionView, self.countLabel].forEach {
            $0.isSkeletonable = true
            $0.showAnimatedGradientSkeleton()
        }
    }
    
    private func hideSkeletonAnimation() {
        [self.collectionView, self.countLabel].forEach {
            $0.hideSkeleton()
        }
    }
    
    private func showSpinner(_ isShow: Bool) {
        self.spinner.isHidden = !isShow
        isShow ? self.spinner.startAnimating() : self.spinner.stopAnimating()
    }
    
}

extension AssetListView: SkeletonCollectionViewDelegate, SkeletonCollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, skeletonCellForItemAt indexPath: IndexPath) -> UICollectionViewCell? {
        return collectionView.dequeueReusableCell(withReuseIdentifier: AssetCVC.identifier, for: indexPath)
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return AssetCVC.identifier
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AssetCVC.identifier, for: indexPath) as? AssetCVC
        else {
            return UICollectionViewCell()
        }
        
        cell.setupCell(data: data[indexPath.row])
        
        return cell
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard scrollView == scrollView,
              let presenter = self.presenter
        else { return }
        
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if maximumOffset - currentOffset <= 0.0 && presenter.isCanLoad {
            self.showSpinner(true)
            
            DispatchQueue.main.async {
                presenter.fetchNextPage()
            }
        }
    }
    
}

extension AssetListView: ActionBarViewDelegate {
    
    func didTapFirstAction() {
        AppLogger.log("FIRST ACTION TAPPED")
    }
    
    func didTapSecondAction() {
        AppLogger.log("SECOND ACTION TAPPED")
    }
    
    func didTapThirdAction() {
        AppLogger.log("THIRD ACTION TAPPED")
    }
    
    func didTapFourthAction() {
        AppLogger.log("FOURTH ACTION TAPPED")
    }
    
}
