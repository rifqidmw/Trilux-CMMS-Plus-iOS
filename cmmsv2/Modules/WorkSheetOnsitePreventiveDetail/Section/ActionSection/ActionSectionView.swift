//
//  ActionSectionView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/02/24.
//

import UIKit

class ActionSectionView: UIView {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var customHeaderView: CustomHeaderView!
    @IBOutlet weak var tableView: UITableView!
    
    var type: WorkSheetOnsitePreventiveDetailType?
    var data: [ActionModel] = []
    
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

extension ActionSectionView {
    
    private func configureSharedComponent() {
        containerView.makeCornerRadius(8)
        containerView.addShadow(4, opacity: 0.2)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ActionTVC.nib, forCellReuseIdentifier: ActionTVC.identifier)
        tableView.rowHeight = 64
        tableView.separatorStyle = .none
    }
    
    func configure(data: [ActionModel], type: WorkSheetOnsitePreventiveDetailType) {
        self.data = data
        self.type = type
        customHeaderView.configure(icon: "ic_board_with_clock", title: "Tindakan", labelAction: "Tambah Tindakan", type: type == .seeOnly
                                   ? .collapsibleAction : .actionLabel)
    }
    
}

extension ActionSectionView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ActionTVC.identifier, for: indexPath) as? ActionTVC
        else {
            return UITableViewCell()
        }
        
        cell.setupCell(data: data[indexPath.row], type: type ?? .seeOnly)
        
        return cell
    }
    
}
