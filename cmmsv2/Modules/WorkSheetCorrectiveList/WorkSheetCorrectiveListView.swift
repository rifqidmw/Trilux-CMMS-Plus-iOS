//
//  WorkSheetCorrectiveView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/03/24.
//

import UIKit

class WorkSheetCorrectiveListView: BaseViewController {
    
    @IBOutlet weak var customNavigationView: CustomNavigationView!
    @IBOutlet weak var searchButton: GeneralButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var actionBarView: ActionBarView!
    
    var presenter: WorkSheetCorrectiveListPresenter?
    var data: [WorkSheetListEntity] = workSheetData
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
    }
    
}

extension WorkSheetCorrectiveListView {
    
    private func setupBody() {
        setupView()
        setupAction()
        setupCollectionVew()
    }
    
    private func setupView() {
        customNavigationView.configure(plainTitle: "Lembar Kerja Korektif", type: .plain)
        searchButton.configure(type: .searchbutton)
        actionBarView.configure(thirdIcon: "ic_setting", thirdTitle: "Status", fourthIcon: "ic_arrow_up_down", fourthTitle: "Urutkan")
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
    
    private func setupCollectionVew() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(WorkSheetCVC.nib, forCellWithReuseIdentifier: WorkSheetCVC.identifier)
    }
    
}

extension WorkSheetCorrectiveListView: UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkSheetCVC.identifier, for: indexPath) as? WorkSheetCVC
        else {
            return UICollectionViewCell()
        }
        
        cell.setupCell(data: data[indexPath.row], type: .normal)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGSize.widthDevice, height: self.data[indexPath.row].status == .done ? 110 : 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}
