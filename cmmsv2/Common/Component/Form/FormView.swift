//
//  FormView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 02/07/24.
//

import UIKit

class FormView: UIView {
    
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var headerFormView: CustomHeaderView!
    @IBOutlet weak var initialHeightHeaderViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var valueTextField: GeneralTextField!
    @IBOutlet weak var descriptionTextField: GeneralTextField!
    
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
        self.configureSharedComponent()
    }
    
}

extension FormView {
    
    private func configureSharedComponent() {
        self.containerStackView.makeCornerRadius(8)
        self.containerStackView.addShadow(2, position: .bottom, opacity: 0.2)
        self.headerFormView.makeCornerRadius(8, .topCurve)
        self.headerFormView.titleLabel.numberOfLines = 2
    }
    
    func configure(titleForm: String) {
        self.headerFormView.configure(title: titleForm, type: .formHeader)
        self.initialHeightHeaderViewConstraint.constant = 36 + headerFormView.titleLabel.requiredHeight()
        self.valueTextField.configure(title: "Nilai", placeholder: "Masukan Nilai")
        self.valueTextField.textField.keyboardType = .numberPad
        self.descriptionTextField.configure(title: "Keterangan", placeholder: "Masukan Keterangan")
    }
    
}
