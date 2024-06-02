//
//  SparePartSectionView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 02/06/24.
//

import UIKit

protocol SparePartSectionDelegate {
    func didTapDeleteSparePart(id: String)
}

class SparePartSectionView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var initialHeightConstraint: NSLayoutConstraint!
    
    var delegate: SparePartSectionDelegate?
    var data: [LKData.Sparepart] = []
    
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

extension SparePartSectionView {
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SparePartTVC.nib, forCellReuseIdentifier: SparePartTVC.identifier)
        tableView.separatorStyle = .none
    }
    
    func configure(data: [LKData.Sparepart]) {
        self.data = data
        self.tableView.reloadData()
        self.calculateTotalHeight(for: self.tableView)
    }
    
}

extension SparePartSectionView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SparePartTVC.identifier, for: indexPath) as? SparePartTVC
        else {
            return UITableViewCell()
        }
        
        cell.setupCell(data: data[indexPath.row], delegate: self)
        
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

extension SparePartSectionView: SparePartCellDelegate {
    
    func didTapRemoveSparePart(id: String) {
        guard let delegate else { return }
        delegate.didTapDeleteSparePart(id: id)
    }
    
}
