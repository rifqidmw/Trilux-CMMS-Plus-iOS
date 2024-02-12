//
//  PhysicalFunctionalMonitoringView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 08/02/24.
//

import UIKit

class PhysicalFunctionalMonitoringView: UIView {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var customHeaderView: CustomHeaderView!
    @IBOutlet weak var detailInformationContainerStackView: UIStackView!
    @IBOutlet weak var labelView: UIView!
    @IBOutlet weak var labelTableView: UITableView!
    @IBOutlet weak var physicalView: UIView!
    @IBOutlet weak var physicalTableView: UITableView!
    @IBOutlet weak var functionalView: UIView!
    @IBOutlet weak var functionalTableView: UITableView!
    @IBOutlet weak var informationCardView: UIView!
    @IBOutlet weak var informationLabel: UILabel!
    
    var type: WorkSheetOnsitePreventiveDetailType?
    var dataLabel: [String] = []
    var dataPhysical: [PreparationStatus] = []
    var dataFunctional: [PreparationStatus] = []
    
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
        setupTableView(labelTableView)
        setupTableView(physicalTableView)
        setupTableView(functionalTableView)
    }
    
}

extension PhysicalFunctionalMonitoringView {
    
    private func configureSharedComponent() {
        containerView.makeCornerRadius(8)
        containerView.addShadow(4, opacity: 0.2)
        informationCardView.makeCornerRadius(8)
        informationLabel.text = """
        • Aktifkan Abaikan jika data tidak ingin ditampilkan.
        • Centang jika persiapan sudah selesai dilakukan.
        """
        labelView.makeCornerRadius(8)
        physicalView.makeCornerRadius(8)
        functionalView.makeCornerRadius(8)
    }
    
    private func setupTableView(_ tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LabelTVC.nib, forCellReuseIdentifier: LabelTVC.identifier)
        tableView.register(StatusTVC.nib, forCellReuseIdentifier: StatusTVC.identifier)
        tableView.rowHeight = 28
        tableView.separatorStyle = .none
    }
    
    func configure(
        labelData: [String],
        physicalData: [PreparationStatus],
        functionalData: [PreparationStatus],
        type: WorkSheetOnsitePreventiveDetailType) {
            self.dataLabel = labelData
            self.dataPhysical = physicalData
            self.dataFunctional = functionalData
            self.type = type
            informationCardView.isHidden = type == .seeOnly
            customHeaderView.configure(icon: "ic_statistic_up", title: "Pemantauan Fisik & Fungsi", type: type == .seeOnly
                                       ? .collapsibleAction : .dismissSwitch)
        }
    
}

extension PhysicalFunctionalMonitoringView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case labelTableView:
            return dataLabel.count
        case physicalTableView:
            return dataPhysical.count
        case functionalTableView:
            return dataFunctional.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case labelTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LabelTVC.identifier, for: indexPath) as? LabelTVC else {
                return UITableViewCell()
            }
            cell.setupCell(label: dataLabel[indexPath.row])
            return cell
        case physicalTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StatusTVC.identifier, for: indexPath) as? StatusTVC else {
                return UITableViewCell()
            }
            cell.setupCell(status: dataPhysical[indexPath.row], type: self.type ?? .seeOnly)
            return cell
        case functionalTableView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StatusTVC.identifier, for: indexPath) as? StatusTVC else {
                return UITableViewCell()
            }
            cell.setupCell(status: dataFunctional[indexPath.row], type: self.type ?? .seeOnly)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}
