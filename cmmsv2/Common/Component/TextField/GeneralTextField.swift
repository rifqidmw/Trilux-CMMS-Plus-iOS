//
//  GeneralTextField.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/01/24.
//

import UIKit
import Combine

class GeneralTextField: UIView {
    
    @IBOutlet weak var showHideButton: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var anyCancellable = Set<AnyCancellable>()
    var fieldType: GeneralTextFieldType = .normal {
        didSet {
            configureFieldType()
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
        setupAction()
    }
    
}

extension GeneralTextField {
    
    private func setupAction() {
        showHideButton.gesture()
            .sink { [weak self] _ in
                guard let self else { return }
                self.textField.isSecureTextEntry.toggle()
                showHideButton.image = UIImage(systemName: textField.isSecureTextEntry ? "eye.slash.fill" : "eye.fill")
            }
            .store(in: &anyCancellable)
    }
    
    func configure(title: String, placeholder: String, type: GeneralTextFieldType) {
        titleLabel.text = title
        textField.configurePlaceHolder(font: UIFont.robotoRegular(14), color: UIColor.customPlaceholderColor, placeHolderText: placeholder)
        
        textField.makeCornerRadius(8)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.size.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        fieldType = type
    }
    
    private func configureFieldType() {
        switch fieldType {
        case .normal:
            textField.isSecureTextEntry = false
            showHideButton.isHidden = true
        case .password:
            textField.isSecureTextEntry = true
            showHideButton.isHidden = false
        }
    }
    
}

enum GeneralTextFieldType {
    case normal
    case password
}
