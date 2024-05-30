//
//  AddPreventiveBottomSheet.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 30/05/24.
//

import UIKit

class AddPreventiveBottomSheet: BaseNonNavigationController {
    
    @IBOutlet weak var containerAssetView: UIView!
    @IBOutlet weak var containerAssetHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var customHeaderView: CustomHeaderView!
    @IBOutlet weak var serialNumberView: InformationCardView!
    @IBOutlet weak var brandView: InformationCardView!
    @IBOutlet weak var typeView: InformationCardView!
    @IBOutlet weak var installationView: InformationCardView!
    @IBOutlet weak var roomView: InformationCardView!
    @IBOutlet weak var containerSelectCategoryView: UIView!
    @IBOutlet weak var containerSelectCategoryHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var selectCategoryTableView: UIView!
    @IBOutlet weak var saveButton: GeneralButton!
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
    }
    
}

extension AddPreventiveBottomSheet {
    
    private func setupBody() {
        setupView()
        setupAction()
    }
    
    private func setupView() {
        containerAssetView.makeCornerRadius(8)
        containerAssetView.addShadow(0.4)
        customHeaderView.configure(icon: "ic_notes_board", title: "Nama Aset", type: .plain)
        serialNumberView.configureView(title: "Serial Number", value: "-")
        brandView.configureView(title: "Merk", value: "-")
        typeView.configureView(title: "Tipe", value: "-")
        installationView.configureView(title: "Instalasi", value: "-")
        roomView.configureView(title: "Ruangan", value: "-")
        
        containerSelectCategoryView.makeCornerRadius(8)
        containerSelectCategoryView.addShadow(0.4)
        saveButton.configure(title: "Simpan")
    }
    
    private func setupAction() {
        
    }
    
}
