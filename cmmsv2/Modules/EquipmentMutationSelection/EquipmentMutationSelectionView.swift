//
//  EquipmentMutationSelectionView.swift
//  cmmsv2
//
//  Created by macbook  on 10/09/24.
//

import UIKit

class EquipmentMutationSelectionView: BaseViewController {
    
    @IBOutlet weak var customNavigationView: CustomNavigationView!
    @IBOutlet weak var assetContainerView: UIView!
    @IBOutlet weak var assetHeaderView: CustomHeaderView!
    @IBOutlet weak var installationView: InformationCardView!
    @IBOutlet weak var dateView: InformationCardView!
    @IBOutlet weak var timeView: InformationCardView!
    @IBOutlet weak var assetRequestCountView: InformationCardView!
    @IBOutlet weak var containerMutationTableView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var initialHeightTableViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var saveButton: GeneralButton!
    @IBOutlet weak var scanButton: GeneralButton!
    
    var presenter: EquipmentMutationSelectionPresenter?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.validateUser()
    }
    
}

extension EquipmentMutationSelectionView {
    
    private func setupBody() {
        setupView()
        setupAction()
    }
    
    private func setupView() {
        [containerMutationTableView,
         assetContainerView].forEach {
            $0.makeCornerRadius(12)
            $0.layer.opacity = 1.0
            $0.addShadow(4, position: .bottom, opacity: 0.2)
        }
        customNavigationView.configure(toolbarTitle: "Memilih Alat Mutasi", type: .plain)
        assetHeaderView.configure(icon: "ic_notes_board", title: "-", type: .plain)
        installationView.configureView(title: "Instalasi Pemohon", value: "-")
        dateView.configureView(title: "Tanggal", value: "-")
        timeView.configureView(title: "Waktu", value: "-")
        assetRequestCountView.configureView(title: "Jumlah Permintaan Alat", value: "-")
        saveButton.configure(title: "Simpan", type: .bordered)
        scanButton.configure(title: "Scan")
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
    
}
