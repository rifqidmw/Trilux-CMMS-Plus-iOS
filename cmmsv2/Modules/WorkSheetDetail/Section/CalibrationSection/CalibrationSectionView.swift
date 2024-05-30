//
//  CalibrationSectionView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 28/05/24.
//

import UIKit

class CalibrationSectionView: UIView {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var initialHeightConstraint: NSLayoutConstraint!
    
    var data: [LKData.AlatKalibrasi] = []
    
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

extension CalibrationSectionView {
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CalibrationTVC.nib, forCellReuseIdentifier: CalibrationTVC.identifier)
        tableView.separatorStyle = .none
        tableView.makeCornerRadius(8)
    }
    
    func configure(data: [LKData.AlatKalibrasi]) {
        self.data = data
        self.tableView.reloadData()
        self.calculateTotalHeight(for: self.tableView)
    }
    
}

extension CalibrationSectionView: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].detail?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionData = data[indexPath.section]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CalibrationTVC.identifier, for: indexPath) as? CalibrationTVC,
              let rowData = sectionData.detail?[indexPath.row]
        else {
            return UITableViewCell()
        }
        
        cell.setupCell(data: rowData)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        
        let label = UILabel()
        label.text = data[section].nama
        label.font = UIFont.robotoMedium(14)
        label.textColor = UIColor.customPrimaryColor
        label.textAlignment = .left
        
        label.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            label.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 0),
            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0)
        ])
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func calculateTotalHeight(for tableView: UITableView) {
        var totalHeight: CGFloat = 0
        for section in 0..<tableView.numberOfSections {
            totalHeight += self.tableView(tableView, heightForHeaderInSection: section)
            for row in 0..<tableView.numberOfRows(inSection: section) {
                let indexPath = IndexPath(row: row, section: section)
                totalHeight += tableView.rectForRow(at: indexPath).height
            }
        }
        initialHeightConstraint.constant = totalHeight + 60
    }
    
}
