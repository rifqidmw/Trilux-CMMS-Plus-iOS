//
//  TestingSectionView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 23/05/24.
//

import UIKit

struct AccordionEntity {
    let title: String
    let icon: String
    var isCollapsed = false
    var view: UIView?
    let type: CustomHeaderType
}

class AccordionView: UIView {
    
    @IBOutlet var containerContentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @Published public var totalHeightTable: CGFloat = 48
    var data: [AccordionEntity] = []
    
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
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
        self.setupTableView()
        self.configureComponent()
    }
    
}

extension AccordionView {
    
    private func configureComponent() {
        containerContentView.makeCornerRadius(8)
        containerContentView.addShadow(2, opacity: 0.2)
    }
    
    func configure(title: String, icon: String, view: UIView, type: CustomHeaderType = .collapsibleAction) {
        let entity = AccordionEntity(title: title, icon: icon, isCollapsed: type == .dismissSwitch ? true : false, view: view, type: type)
        self.data.append(entity)
        self.tableView.reloadData()
    }
    
}

extension AccordionView: UITableViewDataSource, UITableViewDelegate {
    
    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(AccordionCell.nib, forCellReuseIdentifier: AccordionCell.identifier)
        self.tableView.separatorStyle = .none
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AccordionCell.identifier, for: indexPath) as? AccordionCell
        else {
            return UITableViewCell()
        }
        cell.setupCell(data: self.data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        tableView.beginUpdates()
        self.data[indexPath.row].isCollapsed = !self.data[indexPath.row].isCollapsed
        tableView.reloadRows(at: [indexPath], with: .automatic)
        //        tableView.endUpdates()
        self.calculateTotalHeight(for: tableView)
    }
    
    func calculateTotalHeight(for tableView: UITableView) {
        var totalHeight: CGFloat = 0
        for row in 0..<tableView.numberOfRows(inSection: 0) {
            let indexPath = IndexPath(row: row, section: 0)
            totalHeight += tableView.rectForRow(at: indexPath).height
        }
        totalHeightTable = totalHeight
    }
    
}
