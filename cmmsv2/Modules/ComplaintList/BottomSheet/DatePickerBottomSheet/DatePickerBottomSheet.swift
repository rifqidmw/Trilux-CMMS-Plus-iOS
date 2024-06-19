//
//  DatePickerBottomSheet.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 19/06/24.
//

import UIKit
import Combine

protocol DatePickerBottomSheetDelegate: AnyObject {
    func didSelectDate(_ date: Date)
}

class DatePickerBottomSheet: BaseViewController {
    
    @IBOutlet weak var dismissAreaView: UIView!
    @IBOutlet weak var containerDatePickerView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var cancelBtn: GeneralButton!
    @IBOutlet weak var selectBtn: GeneralButton!
    
    weak var delegate: DatePickerBottomSheetDelegate?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
    }
    
}

extension DatePickerBottomSheet {
    
    private func setupBody() {
        setupView()
        setupAction()
    }
    
    private func setupView() {
        containerDatePickerView.makeCornerRadius(8)
        datePicker.makeCornerRadius(8)
        datePicker.datePickerMode = .date
        datePicker.calendar = .current
        selectBtn.configure(title: "Pilih")
        selectBtn.makeCornerRadius(8)
        cancelBtn.configure(title: "Batal", type: .bordered)
        cancelBtn.makeCornerRadius(8)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            UIView.animate(withDuration: 0.2, animations: {
                self.dismissAreaView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            })
        }
    }
    
    private func setupAction() {
        Publishers.Merge(dismissAreaView.gesture(), cancelBtn.gesture())
            .sink { [weak self] _ in
                self?.dismissBottomSheet()
            }
            .store(in: &anyCancellable)
        
        selectBtn.gesture()
            .sink { [weak self] _ in
                guard let self, let delegate = self.delegate else { return }
                delegate.didSelectDate(self.datePicker.date)
                dismissBottomSheet()
            }
            .store(in: &anyCancellable)
    }
    
    private func dismissBottomSheet() {
        UIView.animate(withDuration: 0.2, animations: {
            self.dismissAreaView.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        }) { _ in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
