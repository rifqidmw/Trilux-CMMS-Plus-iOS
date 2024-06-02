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
    
    var data: [LKData.Pemantauan] = []
    
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
        tableView.makeCornerRadius(8)
    }
    
    func configure(data: [LKData.Pemantauan]) {
        self.data = data
        self.tableView.reloadData()
        self.calculateTotalHeight(for: self.tableView)
    }
    
}

extension PhysicalMonitoringSectionView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhysicalMonitoringTVC.identifier, for: indexPath) as? PhysicalMonitoringTVC
        else {
            return UITableViewCell()
        }
        
        if indexPath.row == 0 {
            cell.setupCell(data: LKData.Pemantauan(key: "", fisik: "", fungsi: "", label: "", fisikText: "", fungsiText: ""), type: .header)
        } else {
            let dataIndex = indexPath.row - 1
            guard dataIndex >= 0, dataIndex < self.data.count else {
                cell.setupCell(data: LKData.Pemantauan(key: "", fisik: "", fungsi: "", label: "", fisikText: "", fungsiText: ""), type: .content)
                return cell
            }
            
            let itemData = self.data[dataIndex]
            cell.setupCell(data: itemData, type: .content)
        }
        
        return cell
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
