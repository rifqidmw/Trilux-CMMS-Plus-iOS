//
//  AddTaskSectionView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 07/07/24.
//

import UIKit

class AddTaskSectionView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    @Published public var totalHeightTable: CGFloat = 0
    
    var data: [TaskLK] = []
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

extension AddTaskSectionView {
    
    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(AddTaskCell.nib, forCellReuseIdentifier: AddTaskCell.identifier)
        self.tableView.separatorStyle = .none
    }
    
    func configure(data: [TaskLK]) {
        self.data = data
        self.selectedStates = Array(repeating: false, count: data.count)
        self.tableView.reloadData()
        self.calculateTotalHeight(for: self.tableView)
    }
    
    func addTask(_ task: TaskLK) {
        self.data.append(task)
        self.selectedStates.append(false)
        self.tableView.reloadData()
        self.calculateTotalHeight(for: self.tableView)
    }
    
}

extension AddTaskSectionView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddTaskCell.identifier, for: indexPath) as? AddTaskCell
        else {
            return UITableViewCell()
        }
        
        cell.setupCell(data: self.data[indexPath.row], index: indexPath, delegate: self)
        
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
        self.totalHeightTable = totalHeight
    }
    
}

extension AddTaskSectionView: AddTaskCellDelegate {
    
    func didTapDeleteTask(_ indexPath: IndexPath) {
        self.data.remove(at: indexPath.row)
        self.selectedStates.remove(at: indexPath.row)
        self.tableView.reloadData()
        self.calculateTotalHeight(for: self.tableView)
    }
}
