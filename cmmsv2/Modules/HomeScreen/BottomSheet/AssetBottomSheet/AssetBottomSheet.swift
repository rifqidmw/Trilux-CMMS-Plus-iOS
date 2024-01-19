//
//  AssetBottomSheet.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 14/01/24.
//

import UIKit

class AssetBottomSheet: BaseNonNavigationController {
    
    @IBOutlet weak var dismissAreaView: UIView!
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    @IBOutlet weak var tableView: UITableView!
    
    var data: [MenuModel] = assetData
    
    override func didLoad() {
        super.didLoad()
        setupBody()
    }
    
}

extension AssetBottomSheet {
    
    private func setupBody() {
        setupView()
        setupAction()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MenuItemTVC.nib, forCellReuseIdentifier: MenuItemTVC.identifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = 60
        tableView.isScrollEnabled = false
    }
    
    private func setupView() {
        bottomSheetView.configure(type: .withoutHandleBar)
    }
    
    private func setupAction() {
        bottomSheetView.handleBarArea.gesture()
            .sink { [weak self] _ in
                guard let self else { return }
                self.dismiss(animated: true)
            }
            .store(in: &anyCancellable)
        
        dismissAreaView.gesture()
            .sink { [weak self] _ in
                guard let self else { return }
                self.dismiss(animated: true)
            }
            .store(in: &anyCancellable)
    }
    
}

extension AssetBottomSheet: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuItemTVC.identifier, for: indexPath) as? MenuItemTVC
        else {
            return UITableViewCell()
        }
        
        cell.setupCell(data: data[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            AppLogger.log("GO TO ASSET MEDIC")
        case 1:
            AppLogger.log("GO TO ASSET NON MEDIC")
        default: break
        }
    }
    
}
