//
//  CalibrationMeasurementView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 06/02/24.
//

import UIKit

class CalibrationMeasurementView: UIView {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerButtonStackView: UIStackView!
    @IBOutlet weak var deleteButton: GeneralButton!
    @IBOutlet weak var updateButton: GeneralButton!
    
    var type: WorkSheetOnsitePreventiveDetailType?
    var data: [MeasurementModel] = []
    
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
        setupView()
    }
    
}

extension CalibrationMeasurementView {
    
    func configureTitle(title: String) {
        titleLabel.text = title
    }
    
    private func setupView() {
        configureSharedComponent()
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CalibrationMeasurementTVC.nib, forCellReuseIdentifier: CalibrationMeasurementTVC.identifier)
        tableView.separatorInset = .zero
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func configureSharedComponent() {
        deleteButton.configure(title: "Hapus", type: .normal, backgroundColor: UIColor.customIndicatorColor3, titleColor: UIColor.customRedColor)
        updateButton.configure(title: "Hapus", type: .normal, titleColor: UIColor.white)
        
        deleteButton.makeCornerRadius(4)
        updateButton.makeCornerRadius(4)
        
        containerView.makeCornerRadius(8)
    }
    
}

extension CalibrationMeasurementView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CalibrationMeasurementTVC.identifier, for: indexPath) as? CalibrationMeasurementTVC
        else {
            return UITableViewCell()
        }
        
        cell.setupCell(data: data[indexPath.row])
        
        return cell
    }
    
}
