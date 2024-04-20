//
//  WorkSheetOnsitePreventiveListView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 22/01/24.
//

import UIKit

class WorkSheetOnsitePreventiveListView: BaseViewController {
    
    @IBOutlet weak var navigationView: CustomNavigationView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var data: [WorkSheetListEntity] = onsitePreventiveData
    var presenter: WorkSheetOnsitePreventiveListPresenter?
    
    override func didLoad() {
        super.didLoad()
        setupBody()
    }
    
}

extension WorkSheetOnsitePreventiveListView {
    
    private func setupBody() {
        setupView()
        setupAction()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(WorkSheetCVC.nib, forCellWithReuseIdentifier: WorkSheetCVC.identifier)
    }
    
    private func setupView() {
        navigationView.configure(plainTitle: "Lembar Kerja", type: .plain)
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
    
}

extension WorkSheetOnsitePreventiveListView: UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGSize.widthDevice, height: self.data[indexPath.row].status == .done ? 110 : 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let status = data[indexPath.row].status
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        
        self.showOverlay()
        presenter.showBottomSheetAction(navigation: navigation, type: status == .ongoing ? .work : .see, delegate: self)
    }
    
}

extension WorkSheetOnsitePreventiveListView: WorkSheetOnsitePreventiveDelegate {
    
    func didTapDetailPreventive() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToDetailPage(navigation: navigation, type: .seeOnly)
    }
    
    func didTapContinueWorking() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToDetailPage(navigation: navigation, type: .workContinue)
    }
    
}
