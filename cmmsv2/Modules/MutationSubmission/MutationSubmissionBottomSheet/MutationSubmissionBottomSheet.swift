//
//  MutationSubmissionBottomSheet.swift
//  cmmsv2
//
//  Created by macbook  on 11/10/24.
//

import UIKit
import Combine

protocol MutationSubmissionBottomSheetDelegate: AnyObject {
    func didSelectData(_ id: String?, title: String?, for type: MutationSubmissionBottomSheetType)
}

struct MutationSubmissionBottomSheetData {
    let id: String?
    let title: String?
}

enum MutationSubmissionBottomSheetType {
    case installation
    case equipment
}

class MutationSubmissionBottomSheet: BaseNonNavigationController {
    
    @IBOutlet weak var dismissAreaView: UIView!
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerTextFieldView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var type: MutationSubmissionBottomSheetType?
    var data: [MutationSubmissionBottomSheetData] = []
    var filteredData: [MutationSubmissionBottomSheetData] = []
    weak var delegate: MutationSubmissionBottomSheetDelegate?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.showBottomSheet()
        self.filteredData = self.data
    }
    
}

extension MutationSubmissionBottomSheet {
    
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
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.showsHorizontalScrollIndicator = false
    }
    
    private func setupView() {
        self.containerTextFieldView.makeCornerRadius(8)
        guard let type else { return }
        switch type {
        case .installation:
            self.titleLabel.text = "Pilih Instalasi/Ruangan"
            self.searchTextField.placeholder = "Cari instalasi atau ruangan yang diinginkan"
        case .equipment:
            self.titleLabel.text = "Pilih Alat"
            self.searchTextField.placeholder = "Cari alat yang diinginkan"
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
        self.searchTextField.delegate = self
    }
    
}

extension MutationSubmissionBottomSheet: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectionTVC.identifier, for: indexPath) as? SelectionTVC
        else {
            return UITableViewCell()
        }
        
        let groupedData = self.filteredData[indexPath.row]
        cell.setupCell(title: groupedData.title ?? "", type: .plain)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let delegate, let type else { return }
        self.dismissBottomSheet() {
            delegate.didSelectData(self.filteredData[indexPath.row].id ?? "", title: self.filteredData[indexPath.row].title ?? "", for: type)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension MutationSubmissionBottomSheet: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if text.isEmpty {
            self.filteredData = self.data
        } else {
            self.filteredData = self.data.filter { $0.title?.contains(text.lowercased()) ?? false }
        }
        self.tableView.reloadData()
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.filteredData = self.data
        self.tableView.reloadData()
        return true
    }
    
}
