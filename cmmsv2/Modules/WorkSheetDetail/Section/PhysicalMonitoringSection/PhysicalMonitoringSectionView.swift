//
//  PhysicalMonitoringSectionView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 01/06/24.
//

import UIKit

class PhysicalMonitoringSectionView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var initialHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var helpBannerView: HelpBannerView!
    
    var activityType: WorkSheetActivityType?
    var data: [LKData.Pemantauan] = []
    var selectedPhysicalStates: [Bool] = []
    var selectedFunctionalStates: [Bool] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        let view = loadNib()
        view.frame = self.bounds
        self.addSubview(view)
        self.setupTableView()
    }
    
}

extension PhysicalMonitoringSectionView {
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PhysicalMonitoringTVC.nib, forCellReuseIdentifier: PhysicalMonitoringTVC.identifier)
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
    }
    
    func configure(data: [LKData.Pemantauan], activity: WorkSheetActivityType) {
        self.data = data
        self.selectedPhysicalStates = Array(repeating: false, count: data.count)
        self.selectedFunctionalStates = Array(repeating: false, count: data.count)
        self.activityType = activity
        self.tableView.reloadData()
        self.calculateTotalHeight(for: self.tableView)
        self.helpBannerView.isHidden = activity == .view
    }
    
    func getSelectedPreparationData() -> [LKPemantauan] {
        var allData: [LKPemantauan] = []
        for (index, pemantauan) in data.enumerated() {
            let isPhysicalSelected = selectedPhysicalStates[index]
            let isFunctionalSelected = selectedFunctionalStates[index]
            let updatePemantauan = LKPemantauan(
                fisik: isPhysicalSelected ? "1" : "0",
                fisikText: isPhysicalSelected ? MonitoringStatusType.good.getStringValue() : MonitoringStatusType.cross.getStringValue(),
                fungsi: isFunctionalSelected ? "1" : "0",
                fungsiText: isFunctionalSelected ? MonitoringStatusType.good.getStringValue() : MonitoringStatusType.cross.getStringValue(),
                key: pemantauan.key ?? "",
                label: pemantauan.label ?? "")
            allData.append(updatePemantauan)
        }
        return allData
    }
    
}

extension PhysicalMonitoringSectionView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhysicalMonitoringTVC.identifier, for: indexPath) as? PhysicalMonitoringTVC else {
            return UITableViewCell()
        }
        
        if indexPath.row == 0 {
            cell.setupCell(data: LKData.Pemantauan(key: "", fisik: "", fungsi: "", label: "", fisikText: "", fungsiText: ""), type: .header, activityType: self.activityType ?? .view)
        } else {
            let dataIndex = indexPath.row - 1
            let isPhysicalSelected = selectedPhysicalStates[dataIndex]
            let isFunctionalSelected = selectedFunctionalStates[dataIndex]
            guard dataIndex >= 0, dataIndex < self.data.count else {
                cell.setupCell(data: LKData.Pemantauan(key: "", fisik: "", fungsi: "", label: "", fisikText: "", fungsiText: ""), type: .content, activityType: self.activityType ?? .view)
                return cell
            }
            
            let itemData = self.data[dataIndex]
            cell.setupCell(data: itemData, type: .content, activityType: self.activityType ?? .view, isPhysicalSelected: isPhysicalSelected, isFunctionalSelected: isFunctionalSelected)
            
            cell.physicalCheckBoxButton.isUserInteractionEnabled = true
            cell.physicalCheckBoxButton.tag = dataIndex
            cell.physicalCheckBoxButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(togglePhysicalSelection(_:))))
            
            cell.functionalCheckBoxButton.isUserInteractionEnabled = true
            cell.functionalCheckBoxButton.tag = dataIndex
            cell.functionalCheckBoxButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleFunctionalSelection(_:))))
        }
        
        return cell
    }
    
    @objc private func togglePhysicalSelection(_ sender: UITapGestureRecognizer) {
        guard let index = sender.view?.tag else { return }
        selectedPhysicalStates[index].toggle()
        tableView.reloadRows(at: [IndexPath(row: index + 1, section: 0)], with: .automatic)
    }
    
    @objc private func toggleFunctionalSelection(_ sender: UITapGestureRecognizer) {
        guard let index = sender.view?.tag else { return }
        selectedFunctionalStates[index].toggle()
        tableView.reloadRows(at: [IndexPath(row: index + 1, section: 0)], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 36
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func calculateTotalHeight(for tableView: UITableView) {
        var totalHeight: CGFloat = 0
        for row in 0..<tableView.numberOfRows(inSection: 0) {
            let indexPath = IndexPath(row: row, section: 0)
            totalHeight += tableView.rectForRow(at: indexPath).height
        }
        initialHeightConstraint.constant = totalHeight
    }
    
}
