//
//  SparePartSectionView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 02/06/24.
//

import UIKit

enum SparePartType {
    case usage
    case requirement
}

class SparePartSectionView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var initialHeightConstraint: NSLayoutConstraint!
    @Published public var totalHeight: CGFloat = 0
    
    var activityType: WorkSheetActivityType?
    var sparePartType: SparePartType?
    var data: [LKData.Sparepart] = []
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

extension SparePartSectionView {
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SparePartTVC.nib, forCellReuseIdentifier: SparePartTVC.identifier)
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
    }
    
    func configure(data: [LKData.Sparepart], activity: WorkSheetActivityType) {
        self.data = data
        self.selectedStates = Array(repeating: false, count: data.count)
        self.activityType = activity
        self.tableView.reloadData()
        self.calculateTotalHeight(for: self.tableView)
    }
    
    func addSparePart(_ sparepart: LKData.Sparepart, activity: WorkSheetActivityType) {
        self.data.append(sparepart)
        self.selectedStates.append(false)
        self.activityType = activity
        self.tableView.reloadData()
        self.calculateTotalHeight(for: self.tableView)
    }
    
    func getSparePartData() -> [LKSparePart] {
        var allSparePartData: [LKSparePart] = []
        for (_, part) in data.enumerated() {
            let updateSparePartData = LKSparePart(
                harga: part.harga ?? "",
                idLksparepart: part.idLksparepart ?? "",
                idPart: part.idPart ?? "",
                jumlah: part.jumlah ?? "",
                jumlahTotal: part.jumlahTotal ?? "",
                partname: part.partname ?? "")
            allSparePartData.append(updateSparePartData)
        }
        return allSparePartData
    }
    
    func getNewSparePartData() -> [LKNewPart] {
        var allNewPartData: [LKNewPart] = []
        for (_, part) in data.enumerated() {
            let updateNewPart = LKNewPart(
                idLknewpart: part.idLksparepart ?? "",
                idPart: part.idPart ?? "",
                jumlah: part.jumlah ?? "",
                partname: part.partname ?? "")
            allNewPartData.append(updateNewPart)
        }
        return allNewPartData
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
        
        let selectedData = self.data[indexPath.row]
        cell.setupCell(name: selectedData.partname, total: selectedData.jumlah, indexPath: indexPath, delegate: self, activity: self.activityType ?? .view)
        
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
        self.initialHeightConstraint.constant = totalHeight
        self.totalHeight = totalHeight
    }
    
}

extension SparePartSectionView: SparePartCellDelegate {
    
    func didTapRemoveSparePart(_ indexPath: IndexPath) {
        self.data.remove(at: indexPath.row)
        self.selectedStates.remove(at: indexPath.row)
        self.tableView.reloadData()
        self.calculateTotalHeight(for: self.tableView)
    }
    
}
