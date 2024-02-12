//
//  ElectricalMeasurementView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 08/02/24.
//

import UIKit

class ElectricalMeasurementView: UIView {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var customHeaderView: CustomHeaderView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerFormStackView: UIStackView!
    @IBOutlet weak var voltageFormView: UIView!
    @IBOutlet weak var headerVoltageFormView: CustomHeaderView!
    @IBOutlet weak var valueVoltageTextField: GeneralTextField!
    @IBOutlet weak var descriptionVoltageTextField: GeneralTextField!
    @IBOutlet weak var EarthingProtectiveView: UIView!
    @IBOutlet weak var headerEarthingProtectiveView: CustomHeaderView!
    @IBOutlet weak var valueEarthingProtectiveTextField: GeneralTextField!
    @IBOutlet weak var descriptionEarthingProtectiveTextField: GeneralTextField!
    @IBOutlet weak var isolatedFormView: UIView!
    @IBOutlet weak var headerIsolatedFormView: CustomHeaderView!
    @IBOutlet weak var valueIsolatedFormTextField: GeneralTextField!
    @IBOutlet weak var descriptionIsolatedFormTextField: GeneralTextField!
    @IBOutlet weak var leakageToolFormView: UIView!
    @IBOutlet weak var headerLeakageToolFormView: CustomHeaderView!
    @IBOutlet weak var valueLeakageToolTextField: GeneralTextField!
    @IBOutlet weak var descriptionLeakageToolTextField: GeneralTextField!
    @IBOutlet weak var leakagePatienceFormView: UIView!
    @IBOutlet weak var headerLeakagePatienceFormView: CustomHeaderView!
    @IBOutlet weak var valueLeakagePatienceTextField: GeneralTextField!
    @IBOutlet weak var descriptionLeakagePatienceTextField: GeneralTextField!
    
    var type: WorkSheetOnsitePreventiveDetailType?
    var data: [ElectricalMeasurementModel] = []
    
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
        configureHeaderView()
        configureTextField()
        setupTableView()
    }
    
}

extension ElectricalMeasurementView {
    
    private func configureSharedComponent() {
        [containerView,
         voltageFormView,
         EarthingProtectiveView,
         isolatedFormView,
         leakageToolFormView,
         leakagePatienceFormView].forEach {
            $0.makeCornerRadius(8)
            $0.addShadow(4, opacity: 0.2)
        }
    }
    
    private func configureHeaderView() {
        headerVoltageFormView.configure(title: "Tegangan jala-jala(-+ 10%)", type: .formHeader)
        headerEarthingProtectiveView.configure(title: "Tahanan protektif pembumian(0.5 omega)", type: .formHeader)
        headerIsolatedFormView.configure(title: "Tahanan isolasi(> 2 mega)", type: .formHeader)
        headerLeakageToolFormView.configure(title: "Arus bocor pada alat(< 500)", type: .formHeader)
        headerLeakagePatienceFormView.configure(title: "Arus bocor pada bagian yang diaplikasikan ke pasien(< 100))", type: .formHeader)
    }
    
    private func configureTextField() {
        [valueVoltageTextField,
         valueEarthingProtectiveTextField,
         valueIsolatedFormTextField,
         valueLeakageToolTextField,
         valueLeakagePatienceTextField].forEach {
            $0?.configure(title: "Nilai", placeholder: "Masukan nilai", type: .number)
        }
        
        [descriptionVoltageTextField,
         descriptionEarthingProtectiveTextField,
         descriptionIsolatedFormTextField,
         descriptionLeakageToolTextField,
         descriptionLeakagePatienceTextField].forEach {
            $0?.configure(title: "Keterangan", placeholder: "Masukan keterangan", type: .normal)
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ElectricalMeasurementTVC.nib, forCellReuseIdentifier: ElectricalMeasurementTVC.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
    }
    
    func configure(data: [ElectricalMeasurementModel], type: WorkSheetOnsitePreventiveDetailType) {
        self.data = data
        self.type = type
        tableView.isHidden = type == .workContinue
        containerFormStackView.isHidden = type == .seeOnly
        customHeaderView.configure(icon: "ic_thunder", title: "Pengukuran Keselamatan Listrik", type: type == .seeOnly
                                   ? .collapsibleAction : .dismissSwitch)
    }
    
}

extension ElectricalMeasurementView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ElectricalMeasurementTVC.identifier, for: indexPath) as? ElectricalMeasurementTVC
        else {
            return UITableViewCell()
        }
        
        cell.setupCell(data: data[indexPath.row])
        
        return cell
    }
    
}
