//
//  GeneralTextField.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/01/24.
//

import UIKit
import Combine

class GeneralTextField: UIView {
    
    @IBOutlet weak var containerTextFieldView: UIView!
    @IBOutlet weak var showHideButton: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var containerDefaultLabelView: UIView!
    @IBOutlet weak var defaultLabel: UILabel!
    
    var anyCancellable = Set<AnyCancellable>()
    var currentType: GeneralTextFieldType = .normal
    
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
        self.textField.delegate = self
        setupAction()
    }
    
}

extension GeneralTextField {
    
    private func setupAction() {
        showHideButton.gesture()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.textField.isSecureTextEntry.toggle()
                self.showHideButton.makeAnimation {
                    self.showHideButton.image = self.textField.isSecureTextEntry ? UIImage(systemName: "eye.fill") : UIImage(systemName: "eye.slash.fill")?.withTintColor(UIColor.customPrimaryColor, renderingMode: .alwaysOriginal)
                }
            }
            .store(in: &anyCancellable)
        
    }
    
    func configure(title: String, placeholder: String, type: GeneralTextFieldType = .normal, isDisabled: Bool = false) {
        titleLabel.text = title
        textField.configurePlaceHolder(font: UIFont.robotoRegular(14), color: UIColor.customPlaceholderColor, placeHolderText: placeholder)
        
        textField.makeCornerRadius(8)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.size.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        currentType = type
        
        switch type {
        case .normal:
            containerDefaultLabelView.isHidden = true
            textField.isSecureTextEntry = false
            showHideButton.isHidden = true
        case .number:
            containerDefaultLabelView.isHidden = true
            textField.isSecureTextEntry = false
            showHideButton.isHidden = true
        case .password:
            containerDefaultLabelView.isHidden = true
            textField.isSecureTextEntry = true
            showHideButton.isHidden = false
        case .phoneNumber:
            defaultLabel.text = "+62"
            textField.makeCornerRadius(8, .rightCurve)
            containerDefaultLabelView.makeCornerRadius(8, .leftCurve)
            defaultLabel.makeCornerRadius(12)
            showHideButton.isHidden = true
        }
        
        textField.isUserInteractionEnabled = !isDisabled
        showHideButton.isUserInteractionEnabled = !isDisabled
        showHideButton.tintColor = isDisabled ? UIColor.customPrimaryColor : UIColor.customPlaceholderColor
        textField.textColor = isDisabled ? UIColor.customPlaceholderColor : UIColor.customDarkGrayColor
    }
    
}

extension GeneralTextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text, let textRange = Range(range, in: text) else {
            return false
        }
        
        let updatedText = text.replacingCharacters(in: textRange, with: string)
        
        switch currentType {
        case .phoneNumber, .number:
            let allowedCharacterSet = CharacterSet(charactersIn: "0123456789")
            let isValidInput = updatedText.rangeOfCharacter(from: allowedCharacterSet.inverted) == nil
            return isValidInput
        default:
            return true
        }
    }
    
}

enum GeneralTextFieldType {
    case normal
    case number
    case password
    case phoneNumber
}
