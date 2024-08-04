//
//  ReminderPreventiveBottomSheet.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 04/08/24.
//

import UIKit
import Combine

protocol ReminderPreventiveBottomSheetDelegate: AnyObject {
    func didTapDetailPreventive(_ data: WorkSheetRequestEntity, wo: WorkSheetListEntity)
}

class ReminderPreventiveBottomSheet: BaseNonNavigationController {
    
    @IBOutlet weak var dismissAreaView: UIView!
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var closeButton: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: ReminderPreventiveBottomSheetDelegate?
    var data: [ReminderPreventiveData] = []
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.showBottomSheet()
    }
    
}

extension ReminderPreventiveBottomSheet {
    
    private func setupBody() {
        setupView()
        setupAction()
    }
    
    private func setupView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ReminderPreventiveCell.nib, forCellReuseIdentifier: ReminderPreventiveCell.identifier)
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
    }
    
    private func setupAction() {
        Publishers.Merge3(
            dismissAreaView.gesture(),
            bottomSheetView.handleBarArea.gesture(),
            closeButton.gesture())
        .sink { [weak self] _ in
            guard let self else { return }
            self.dismissBottomSheet()
        }
        .store(in: &anyCancellable)
    }
    
}

extension ReminderPreventiveBottomSheet: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReminderPreventiveCell.identifier, for: indexPath) as? ReminderPreventiveCell
        else {
            return UITableViewCell()
        }
        
        cell.setupCell(data: self.data[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let delegate else { return }
        let adjustedItem = self.data[indexPath.row]
        let request = WorkSheetRequestEntity(id: adjustedItem.idLk, action: "kerjakan")
        let worksheet = WorkSheetListEntity(
            idLK: adjustedItem.idLk ?? "",
            idAsset: adjustedItem.idAsset ?? "",
            serialNumber: adjustedItem.serial ?? "",
            title: adjustedItem.assetname ?? "",
            description: "",
            room: adjustedItem.ruangan ?? "",
            installation: adjustedItem.instalasi ?? "",
            dateTime: adjustedItem.dateText ?? "",
            brandName: adjustedItem.brandname ?? "",
            lkNumber: adjustedItem.lkNumber ?? "",
            lkStatus: adjustedItem.lkStatus ?? "",
            category: WorkSheetCategory.none,
            status: WorkSheetStatus(rawValue: adjustedItem.txtStatus ?? "") ?? WorkSheetStatus.none)
        self.dismissBottomSheet() {
            delegate.didTapDetailPreventive(request, wo: worksheet)
        }
    }
    
}
