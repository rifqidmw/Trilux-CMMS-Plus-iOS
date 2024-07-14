//
//  ElectricInputSectionView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 02/07/24.
//

import UIKit

class ElectricInputSectionView: UIView {
    
    @IBOutlet weak var voltageFormView: FormView!
    @IBOutlet weak var protectiveFormView: FormView!
    @IBOutlet weak var isolationFormView: FormView!
    @IBOutlet weak var leakageCurrentFormView: FormView!
    @IBOutlet weak var leakageCurrentPatientFormView: FormView!
    @IBOutlet weak var initialHeightConstraint: NSLayoutConstraint!
    
    var data: [LKData.Listrik] = [] {
        didSet {
            configure(data: data)
        }
    }
    
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
    }
    
}

extension ElectricInputSectionView {
    
    private func configure(data: [LKData.Listrik]) {
        let formViews = [voltageFormView, protectiveFormView, isolationFormView, leakageCurrentFormView, leakageCurrentPatientFormView]
        
        for (index, formView) in formViews.enumerated() {
            if index < data.count {
                formView?.configure(titleForm: "\(data[index].label ?? "-") (\(data[index].ambangBatas ?? "-"))")
            } else {
                formView?.configure(titleForm: "")
            }
        }
    }
    
    func setElectricInputtedData() -> [ListrikLK] {
        let formViews = [voltageFormView, protectiveFormView, isolationFormView, leakageCurrentFormView, leakageCurrentPatientFormView]
        var allInputtedData: [ListrikLK] = []
        
        for (index, listrik) in data.enumerated() {
            guard index < formViews.count else { break }
            let formView = formViews[index]
            let valUkur = formView?.valueTextField.textField.text ?? ""
            let desc = formView?.descriptionTextField.textField.text ?? ""
            
            let updateListrik = ListrikLK(
                ambangBatas: listrik.ambangBatas ?? "",
                desc: desc,
                key: listrik.key ?? "",
                label: listrik.label ?? "",
                valUkur: valUkur
            )
            allInputtedData.append(updateListrik)
        }
        
        return allInputtedData
    }
}
