//
//  PreventiveSectionView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 02/06/24.
//

import UIKit

class PreventiveSectionView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var initialHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var helpBannerView: HelpBannerView!
    
    var activityType: WorkSheetActivityType?
    var data: [LKData.Preventif] = []
    var selectedStates: [Bool] = []
    
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

extension PreventiveSectionView {
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PreventiveTVC.nib, forCellReuseIdentifier: PreventiveTVC.identifier)
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
    }
    
    func configure(data: [LKData.Preventif], activity: WorkSheetActivityType) {
        self.data = data
        self.selectedStates = Array(repeating: false, count: data.count)
        self.activityType = activity
        self.tableView.reloadData()
        self.calculateTotalHeight(for: self.tableView)
        self.helpBannerView.isHidden = activity == .view
    }
    
    func getSelectedPreventiveData() -> [LKPreventif] {
        var allData: [LKPreventif] = []
        for (index, preventive) in data.enumerated() {
            let isSelected = selectedStates[index]
            let updatedPersiapan = LKPreventif(
                key: preventive.key,
                label: isSelected ? MonitoringStatusType.none.getStringValue() : preventive.label ?? "",
                value: isSelected ? "1" : "0",
                valueText: isSelected ? preventive.valueText : MonitoringStatusType.none.getStringValue()
            )
            allData.append(updatedPersiapan)
        }
        return allData
    }
    
}

extension PreventiveSectionView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PreventiveTVC.identifier, for: indexPath) as? PreventiveTVC
        else {
            return UITableViewCell()
        }
        
        let isSelected = selectedStates[indexPath.row]
        cell.setupCell(data: data[indexPath.row], activityType: self.activityType ?? .view, isSelected: isSelected)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let activityType = activityType, activityType == .working || activityType == .correction else { return }
        selectedStates[indexPath.row].toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
