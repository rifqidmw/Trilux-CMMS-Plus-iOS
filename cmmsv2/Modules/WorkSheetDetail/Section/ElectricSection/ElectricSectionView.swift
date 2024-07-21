//
//  ElectricSectionView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 02/06/24.
//

import UIKit

class ElectricSectionView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var initialHeightConstraint: NSLayoutConstraint!
    
    var data: [LKData.Listrik] = []
    
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

extension ElectricSectionView {
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ElectricTVC.nib, forCellReuseIdentifier: ElectricTVC.identifier)
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
    }
    
    func configure(data: [LKData.Listrik]) {
        self.data = data
        self.tableView.reloadData()
        self.calculateTotalHeight(for: self.tableView)
    }
    
}

extension ElectricSectionView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ElectricTVC.identifier, for: indexPath) as? ElectricTVC else {
            return UITableViewCell()
        }
        
        cell.setupCell(data: data[indexPath.row])
        
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
