//
//  PreventiveMaintenanceView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 08/02/24.
//

import UIKit

class PreventiveMaintenanceView: UIView {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var customHeaderView: CustomHeaderView!
    @IBOutlet weak var tableView: UITableView!
    
    var type: WorkSheetOnsitePreventiveDetailType?
    var data: [PreparationModel] = []
    
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
        configureSharedComponent()
        setupTableView()
    }
    
}

extension PreventiveMaintenanceView {
    
    private func configureSharedComponent() {
        containerView.makeCornerRadius(8)
        containerView.addShadow(4, opacity: 0.2)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PreparationTVC.nib, forCellReuseIdentifier: PreparationTVC.identifier)
        tableView.rowHeight = 40
        tableView.separatorStyle = .none
    }
    
    func configure(data: [PreparationModel], type: WorkSheetOnsitePreventiveDetailType) {
        self.data = data
        self.type = type
        customHeaderView.configure(icon: "ic_document_with_gear", title: "Pemeliharaan Preventif", type: type == .seeOnly
                                   ? .collapsibleAction : .dismissSwitch)
    }
    
}

extension PreventiveMaintenanceView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PreparationTVC.identifier, for: indexPath) as? PreparationTVC
        else {
            return UITableViewCell()
        }
        
        cell.setupCell(data: data[indexPath.row], type: type ?? .seeOnly)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.data[indexPath.row].isSelected = !self.data[indexPath.row].isSelected
        self.tableView.reloadData()
    }
    
}
