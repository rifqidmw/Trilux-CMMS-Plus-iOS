//
//  SelectTechnicalDataBottomSheet.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 03/08/24.
//

import UIKit
import Combine

enum SelectTechnicalDataBottomSheetType {
    case technology
    case priority
    case frequency
    case melopsi
}

protocol SelectTechnicalDataBottomSheetDelegate: AnyObject {
    func didSelectItem(_ key: String, type: SelectTechnicalDataBottomSheetType)
}

class SelectTechnicalDataBottomSheet: BaseNonNavigationController {
    
    @IBOutlet weak var dismissAreaView: UIView!
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerTextFieldView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var data: [ReferenceItem] = []
    var filteredData: [ReferenceItem] = []
    var type: SelectTechnicalDataBottomSheetType?
    weak var delegate: SelectTechnicalDataBottomSheetDelegate?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.showBottomSheet()
        self.filteredData = self.data
    }
    
}

extension SelectTechnicalDataBottomSheet {
    
    private func setupBody() {
        setupView()
        setupAction()
        setupDelegate()
        setupTableView()
    }
    
    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(SelectionTVC.nib, forCellReuseIdentifier: SelectionTVC.identifier)
        self.tableView.separatorStyle = .none
    }
    
    private func setupView() {
        guard let type else { return }
        self.containerTextFieldView.makeCornerRadius(8)
        switch type {
        case .frequency:
            self.titleLabel.text = "Pilih Frekuensi Pemeliharaan"
        case .melopsi:
            self.titleLabel.text = "Pilih EML Faktor"
        case .priority:
            self.titleLabel.text = "Pilih Prioritas"
        case .technology:
            self.titleLabel.text = "Teknologi"
        }
    }
    
    private func setupAction() {
        Publishers.Merge(
            dismissAreaView.gesture(),
            bottomSheetView.handleBarArea.gesture())
        .sink { [weak self] _ in
            guard let self else { return }
            self.dismissBottomSheet()
        }
        .store(in: &anyCancellable)
    }
    
    private func setupDelegate() {
        self.textField.delegate = self
    }
    
}

extension SelectTechnicalDataBottomSheet: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectionTVC.identifier, for: indexPath) as? SelectionTVC
        else {
            return UITableViewCell()
        }
        
        cell.setupCell(title: self.filteredData[indexPath.row].value ?? "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let delegate, let type else { return }
        self.dismissBottomSheet() {
            delegate.didSelectItem(self.filteredData[indexPath.row].key ?? "", type: type)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension SelectTechnicalDataBottomSheet: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if text.isEmpty {
            self.filteredData = self.data
        } else {
            self.filteredData = self.data.filter { $0.value?.lowercased().contains(text.lowercased()) ?? false }
        }
        self.tableView.reloadData()
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.filteredData = self.data
        self.tableView.reloadData()
        return true
    }
    
}
