//
//  DatePickerBottomSheet.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 19/06/24.
//

import UIKit
import Combine

enum DatePickerBottomSheetType {
    case date
    case monthYear
    case year
}

protocol DatePickerBottomSheetDelegate: AnyObject {
    func didSelectDate(_ date: Date, type: DatePickerBottomSheetType)
}

class DatePickerBottomSheet: BaseNonNavigationController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dismissAreaView: UIView!
    @IBOutlet weak var containerDatePickerView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var monthPicker: UIPickerView!
    @IBOutlet weak var yearPicker: UIPickerView!
    @IBOutlet weak var cancelBtn: GeneralButton!
    @IBOutlet weak var selectBtn: GeneralButton!
    
    var type: DatePickerBottomSheetType? = .date
    weak var delegate: DatePickerBottomSheetDelegate?
    
    var selectedMonth: Int = Calendar.current.component(.month, from: Date())
    var selectedYear: Int = Calendar.current.component(.year, from: Date())
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.showBottomSheet()
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
        monthPicker.makeCornerRadius(8)
        yearPicker.makeCornerRadius(8)
        datePicker.calendar = .current
        selectBtn.configure(title: "Pilih")
        selectBtn.makeCornerRadius(8)
        cancelBtn.configure(title: "Batal", type: .bordered)
        cancelBtn.makeCornerRadius(8)
        
        datePicker.isHidden = true
        monthPicker.isHidden = true
        yearPicker.isHidden = true
        
        switch self.type {
        case .date:
            datePicker.isHidden = false
            datePicker.datePickerMode = .date
            titleLabel.text = "Pilih Tanggal"
        case .monthYear:
            monthPicker.isHidden = false
            monthPicker.delegate = self
            monthPicker.dataSource = self
            titleLabel.text = "Pilih Bulan"
            
            monthPicker.selectRow(selectedMonth - 1, inComponent: 0, animated: false)
            let currentYear = Calendar.current.component(.year, from: Date())
            monthPicker.selectRow(selectedYear - (currentYear - 50), inComponent: 1, animated: false)
        case .year:
            yearPicker.isHidden = false
            yearPicker.delegate = self
            yearPicker.dataSource = self
            titleLabel.text = "Pilih Tahun"
            
            let currentYear = Calendar.current.component(.year, from: Date())
            yearPicker.selectRow(selectedYear - (currentYear - 50), inComponent: 0, animated: false)
        default: break
        }
    }
    
    private func setupAction() {
        Publishers.Merge(dismissAreaView.gesture(), cancelBtn.gesture())
            .sink { [weak self] _ in
                guard let self else { return }
                self.dismissBottomSheet()
            }
            .store(in: &anyCancellable)
        
        selectBtn.gesture()
            .sink { [weak self] _ in
                guard let self = self,
                      let delegate = self.delegate,
                      let type = self.type
                else { return }
                let selectedDate: Date
                switch type {
                case .monthYear:
                    var components = DateComponents()
                    components.year = self.selectedYear
                    components.month = self.selectedMonth
                    components.day = 1
                    selectedDate = Calendar.current.date(from: components) ?? Date()
                case .year:
                    var components = DateComponents()
                    components.year = self.selectedYear
                    components.month = 1
                    components.day = 1
                    selectedDate = Calendar.current.date(from: components) ?? Date()
                case .date:
                    selectedDate = self.datePicker.date
                }
                self.dismissBottomSheet() {
                    delegate.didSelectDate(selectedDate, type: type)
                }
            }
            .store(in: &anyCancellable)
    }
    
}

extension DatePickerBottomSheet: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerView == yearPicker ? 1 : 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == yearPicker {
            return 100
        } else if component == 0 {
            return 12
        } else {
            return 100
        }
    }
    
    // MARK: - UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == yearPicker {
            return "\(Calendar.current.component(.year, from: Date()) - 50 + row)"
        } else if component == 0 {
            return DateFormatter().monthSymbols[row]
        } else {
            return "\(Calendar.current.component(.year, from: Date()) - 50 + row)"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == yearPicker {
            selectedYear = Calendar.current.component(.year, from: Date()) - 50 + row
        } else if component == 0 {
            selectedMonth = row + 1
        } else {
            selectedYear = Calendar.current.component(.year, from: Date()) - 50 + row
        }
    }
    
}
