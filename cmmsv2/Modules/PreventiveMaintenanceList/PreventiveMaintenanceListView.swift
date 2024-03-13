//
//  PreventiveMaintenanceListView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 11/03/24.
//

import UIKit

class PreventiveMaintenanceListView: BaseViewController {
    
    @IBOutlet weak var customNavigationView: CustomNavigationView!
    @IBOutlet weak var searchButton: GeneralButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var actionBarView: ActionBarView!
    
    var presenter: PreventiveMaintenanceListPresenter?
    var data: [PreventiveMaintenanceListEntity] = dataPreventiveMaintenance
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
    }
    
}

extension PreventiveMaintenanceListView {
    
    private func setupBody() {
        setupView()
        setupAction()
        setupCollectionView()
    }
    
    private func setupView() {
        customNavigationView.configure(plainTitle: "Pemeliharaan Preventif", type: .plain)
        searchButton.configure(type: .searchbutton)
        actionBarView.configure(firstIcon: "ic_installation", firstTitle: "Installasi", secondIcon: "ic_setting", secondTitle: "Status", thirdIcon: "ic_arrow_up_down", thirdTitle: "Urutkan")
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
        collectionView.register(PreventiveMaintenanceCVC.nib, forCellWithReuseIdentifier: PreventiveMaintenanceCVC.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.itemSize = CGSize(width: collectionView.frame.size.width, height: 100)
        collectionView.collectionViewLayout = layout
    }
    
}

extension PreventiveMaintenanceListView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PreventiveMaintenanceCVC.identifier, for: indexPath) as? PreventiveMaintenanceCVC
        else {
            return UICollectionViewCell()
        }
        
        cell.setupCell(data: data[indexPath.row])
        
        return cell
    }
    
}
