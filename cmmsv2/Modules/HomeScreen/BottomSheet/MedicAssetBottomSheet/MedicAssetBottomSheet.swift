//
//  MedicAssetBottomSheet.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 11/01/24.
//

import UIKit

class MedicAssetBottomSheet: BaseNonNavigationController {
    
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    @IBOutlet weak var bottomSheetHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var dataAsset: [MedicAssetModel] = medicAssetData
    var dataWorksheet: [MedicAssetModel] = worksheetData
    
    var type: MedicAssetBottomSheetType?
    
    override func didLoad() {
        super.didLoad()
        setupBody()
    }
    
}

extension MedicAssetBottomSheet {
    
    private func setupBody() {
        setupView()
        setupAction()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MedicAssetItemTVC.nib, forCellReuseIdentifier: MedicAssetItemTVC.identifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = 60
        tableView.isScrollEnabled = false
    }
    
    private func setupView() {
        bottomSheetView.configure(type: .withoutHandleBar)
        
        switch type {
        case .asset:
            titleLabel.text = "Pilih Asset"
            bottomSheetHeightConstraint.constant = 225
        case .worksheet:
            titleLabel.text = "Lembar Kerja"
            bottomSheetHeightConstraint.constant = 280
        default: break
        }
    }
    
    private func setupAction() {
        bottomSheetView.handleBarArea.gesture()
            .sink { [weak self] _ in
                guard let self else { return }
                self.dismiss(animated: true)
            }
            .store(in: &anyCancellable)
    }
    
}

extension MedicAssetBottomSheet: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return type == .asset ? dataAsset.count : dataWorksheet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MedicAssetItemTVC.identifier, for: indexPath) as? MedicAssetItemTVC
        else {
            return UITableViewCell()
        }
        
        cell.setupCell(data: type == .asset ? dataAsset[indexPath.row] : dataWorksheet[indexPath.row])
        
        return cell
    }
    
}
