//
//  AddTaskBottomSheet.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 07/07/24.
//

import UIKit
import Combine

enum InputBottomSheetType {
    case number
    case text
}

protocol InputBottomSheetDelegate: AnyObject {
    func didTapSubmit(_ text: String, type: InputBottomSheetType)
}

class InputBottomSheet: BaseNonNavigationController {
    
    @IBOutlet weak var dismissAreaView: UIView!
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    @IBOutlet weak var containerTextField: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var cancelButton: GeneralButton!
    @IBOutlet weak var saveButton: GeneralButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    weak var delegate: InputBottomSheetDelegate?
    var type: InputBottomSheetType?
    
    override func didLoad() {
        super.didLoad()
        self.showBottomSheet()
        self.setupBody()
    }
    
}

extension InputBottomSheet {
    
    private func setupBody() {
        self.setupView()
        self.setupAction()
    }
    
    private func setupView() {
        containerTextField.makeCornerRadius(8)
        cancelButton.configure(title: "Batal", backgroundColor: UIColor.customIndicatorColor3, titleColor: UIColor.customIndicatorColor4)
        cancelButton.makeCornerRadius(8)
        saveButton.configure(title: "Simpan")
        saveButton.makeCornerRadius(8)
        
        switch type {
        case .number:
            textField.keyboardType = .numberPad
            titleLabel.text = "Tentukan Jumlah"
            textField.placeholder = "Masukan Jumlah"
        case .text:
            textField.keyboardType = .default
            titleLabel.text = "Tambah Tindakan"
            textField.placeholder = "Masukan Tindakan"
        default: break
        }
    }
    
    private func setupAction() {
        Publishers.Merge3(dismissAreaView.gesture(),
                          bottomSheetView.handleBarArea.gesture(),
                          cancelButton.gesture())
        .sink { [weak self] _ in
            guard let self else { return }
            self.dismissBottomSheet()
        }
        .store(in: &anyCancellable)
        
        saveButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let delegate = self.delegate,
                      let type,
                      let text = textField.text, !text.isEmpty
                else { return }
                self.dismissBottomSheet() {
                    delegate.didTapSubmit(text, type: type)
                }
            }
            .store(in: &anyCancellable)
    }
    
}
