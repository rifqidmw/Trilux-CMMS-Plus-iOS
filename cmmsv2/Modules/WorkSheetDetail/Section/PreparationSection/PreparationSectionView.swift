//
//  PreparationSectionView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 06/02/24.
//

import UIKit

class PreparationSectionView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var initialHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var helpBannerView: HelpBannerView!
    
    var activityType: WorkSheetActivityType?
    var data: [LKData.Persiapan] = []
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
        setupTableView()
    }
    
}

extension PreparationSectionView {
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PreparationTVC.nib, forCellReuseIdentifier: PreparationTVC.identifier)
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
    }
    
    func configure(data: [LKData.Persiapan], activity: WorkSheetActivityType) {
        self.data = data
        self.selectedStates = Array(repeating: false, count: data.count)
        self.activityType = activity
        self.tableView.reloadData()
        self.calculateTotalHeight(for: self.tableView)
        self.helpBannerView.isHidden = activity == .view
    }
    
    func getSelectedPreparationData() -> [LKPreventif] {
        var allData: [LKPreventif] = []
        for (index, persiapan) in data.enumerated() {
            let isSelected = selectedStates[index]
            let updatedPersiapan = LKPreventif(
                key: persiapan.key,
                label: persiapan.label,
                value: isSelected ? "1" : "0",
                valueText: isSelected ? PreparationStatusType.none.getStringValue() : PreparationStatusType.no.getStringValue()
            )
            allData.append(updatedPersiapan)
        }
        return allData
    }
    
}

extension PreparationSectionView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PreparationTVC.identifier, for: indexPath) as? PreparationTVC else {
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
    
    func calculateTotalHeight(for tableView: UITableView) {
        var totalHeight: CGFloat = 0
        for row in 0..<tableView.numberOfRows(inSection: 0) {
            let indexPath = IndexPath(row: row, section: 0)
            totalHeight += tableView.rectForRow(at: indexPath).height
        }
        initialHeightConstraint.constant = totalHeight
    }
    
}
