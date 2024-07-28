//
//  SearchTextField.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 18/04/24.
//

import UIKit
import Combine

protocol SearchTextFieldDelegate: AnyObject {
    func searchTextField(_ searchTextField: SearchTextField, didChangeText text: String)
}

class SearchTextField: UIView {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var textField: UITextField!
    
    weak var delegate: SearchTextFieldDelegate?
    private var anyCancellable = Set<AnyCancellable>()
    
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
        self.containerView.makeCornerRadius(8)
        self.containerView.addShadow(0.4)
        self.setupTextField()
    }
    
    private func setupTextField() {
        self.textField.delegate = self
        self.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingDidEnd)
    }
    
    @objc private func textFieldDidChange() {
        guard let text = textField.text,
              let delegate = self.delegate
        else { return }
        delegate.searchTextField(self, didChangeText: text)
    }
    
}

extension SearchTextField: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
