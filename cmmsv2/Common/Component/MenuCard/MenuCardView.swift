//
//  MenuCardView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 14/01/24.
//

import UIKit

class MenuCardView: UIView {
    
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    @IBOutlet weak var bottomSheetHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var data: [MedicAssetModel] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBody()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupBody()
    }
    
    private func setupBody() {
        let view = loadNib()
        view.frame = self.bounds
        self.addSubview(view)
        self.setupView()
        self.setupTableView()
    }
    
}

extension MenuCardView {
    
    func configureTitle(title: String) {
        titleLabel.text = title
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MedicAssetItemTVC.nib, forCellReuseIdentifier: MedicAssetItemTVC.identifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = 60
        tableView.isScrollEnabled = false
    }
    
    private func setupView() {
        bottomSheetView.configure(type: .withoutHandleBar)
    }
    
}

extension MenuCardView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MedicAssetItemTVC.identifier, for: indexPath) as? MedicAssetItemTVC
        else {
            return UITableViewCell()
        }
        
        cell.setupCell(data: data[indexPath.row])
        
        return cell
    }
    
}

