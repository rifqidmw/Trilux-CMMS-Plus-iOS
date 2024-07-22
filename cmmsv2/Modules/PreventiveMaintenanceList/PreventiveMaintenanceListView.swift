//
//  PreventiveMaintenanceListView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 11/03/24.
//

import UIKit
import SkeletonView

class PreventiveMaintenanceListView: BaseViewController {
    
    @IBOutlet weak var customNavigationView: CustomNavigationView!
    @IBOutlet weak var searchTextField: SearchTextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var actionBarView: ActionBarView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var presenter: PreventiveMaintenanceListPresenter?
    var data: [WorkSheetListEntity] = []
    var id: String?
    var workSheet: WorkSheetListEntity?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.validateUser()
    }
    
}

extension PreventiveMaintenanceListView {
    
    private func setupBody() {
        fetchInitialData()
        bindingData()
        setupView()
        setupAction()
        setupCollectionView()
    }
    
    private func setupView() {
        customNavigationView.configure(toolbarTitle: "Pemeliharaan Preventif", type: .plain)
        actionBarView.configure(firstIcon: "square.and.arrow.down", firstTitle: "Installasi", secondIcon: "gearshape", secondTitle: "Status", thirdIcon: "arrow.up.arrow.down.square", thirdTitle: "Urutkan")
        actionBarView.delegate = self
        searchTextField.delegate = self
    }
    
    private func fetchInitialData() {
        guard let presenter else { return }
        presenter.fetchInitData()
    }
    
    private func bindingData() {
        guard let presenter else { return }
        presenter.$preventiveData
            .sink { [weak self] data in
                guard let self
                else {
                    self?.showSpinner(false)
                    return
                }
                self.data = data
                self.hideLoadingPopup()
                self.reloadCollectionViewWithAnimation(self.collectionView)
                self.collectionView.hideSkeleton()
                self.showSpinner(false)
            }
            .store(in: &anyCancellable)
    }
    
    private func showSpinner(_ isShow: Bool) {
        self.spinner.isHidden = !isShow
        isShow ? self.spinner.startAnimating() : self.spinner.stopAnimating()
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
        collectionView.register(WorkSheetCVC.nib, forCellWithReuseIdentifier: WorkSheetCVC.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.collectionView.isSkeletonable = true
            self.collectionView.showAnimatedGradientSkeleton()
        }
    }
    
}

extension PreventiveMaintenanceListView: SkeletonCollectionViewDataSource, SkeletonCollectionViewDelegate, UIScrollViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
        
        cell.setupCell(data: data[indexPath.row], type: .preventive)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let presenter,
              let navigation = self.navigationController,
              let id = self.data[indexPath.row].idLK,
              let status = self.data[indexPath.row].status
        else { return }
        
        self.workSheet = self.data[indexPath.row]
        self.id = id
        
        let type: WorkSheetStatus = {
            switch status {
            case .open:
                return .open
            case .done:
                return .done
            case .ongoing:
                return .ongoing
            case .hold:
                return .hold
            default:
                return .none
            }
        }()
        
        presenter.showSelectActionBottomSheet(navigation, type: type, delegate: self, id: id)
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
                self.reloadCollectionViewWithAnimation(self.collectionView)
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
