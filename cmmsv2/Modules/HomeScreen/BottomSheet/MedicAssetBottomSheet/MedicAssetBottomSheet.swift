//
//  MedicAssetBottomSheet.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 11/01/24.
//

import UIKit

class MedicAssetBottomSheet: BaseNonNavigationController {
    
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var data: [MedicAssetModel] = medicAssetData
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
        case .contract:
            titleLabel.text = "Pilih Kontrak"
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
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MedicAssetItemTVC.identifier, for: indexPath) as? MedicAssetItemTVC
        else {
            return UITableViewCell()
        }
        
        cell.setupCell(data: data[indexPath.row])
        
        return cell
    }
    
}
