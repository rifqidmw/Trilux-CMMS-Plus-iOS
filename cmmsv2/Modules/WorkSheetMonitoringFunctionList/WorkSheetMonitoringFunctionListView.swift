//
//  WorkSheetListView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 14/01/24.
//

import UIKit
import SkeletonView

class WorkSheetMonitoringFunctionListView: BaseViewController {
    
    @IBOutlet weak var navigationView: CustomNavigationView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var searchTextField: SearchTextField!
    
    var presenter: WorkSheetMonitoringFunctionListPresenter?
    var data: [WorkSheetListEntity] = []
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
    }
    
}

extension WorkSheetMonitoringFunctionListView {
    
    private func setupBody() {
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
        presenter.$workSheetData
            .sink { [weak self] data in
                guard let self
                else {
                    self?.showSpinner(false)
                    return
                }
                self.data = data
                self.collectionView.reloadData()
                self.collectionView.hideSkeleton()
                self.showSpinner(false)
            }
            .store(in: &anyCancellable)
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(WorkSheetCVC.nib, forCellWithReuseIdentifier: WorkSheetCVC.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.collectionView.isSkeletonable = true
            self.collectionView.showAnimatedGradientSkeleton()
        }
    }
    
    private func setupView() {
        navigationView.configure(plainTitle: "Lembar Kerja Pemantauan Fungsi", type: .plain)
    }
    
    private func setupAction() {
        navigationView.arrowLeftBackButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let navigation = self.navigationController
                else { return}
                navigation.popViewController(animated: true)
            }
            .store(in: &anyCancellable)
    }
    
    private func showSpinner(_ isShow: Bool) {
        self.spinner.isHidden = !isShow
        isShow ? self.spinner.startAnimating() : self.spinner.stopAnimating()
    }
    
}

extension WorkSheetMonitoringFunctionListView: SkeletonCollectionViewDataSource, SkeletonCollectionViewDelegate, UIScrollViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        return WorkSheetCVC.identifier
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkSheetCVC.identifier, for: indexPath) as? WorkSheetCVC
        else {
            return UICollectionViewCell()
        }
        
        cell.setupCell(data: data[indexPath.row], type: .monitoring)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        self.showOverlay()
        presenter.showBottomSheetPreviewWorkSheet(navigation: navigation, delegate: self)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}

extension WorkSheetMonitoringFunctionListView: WorkSheetListDelegate {
    
    func didTapDetailWorkSheet() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToDetailWorkSheet(navigation: navigation)
    }
    
}
