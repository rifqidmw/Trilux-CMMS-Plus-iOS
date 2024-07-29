//
//  InstallationBottomSheet.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 23/07/24.
//

import UIKit
import Combine

protocol InstallationBottomSheetDelegate: AnyObject {
    func didSelectInstallation(_ installation: InstallationData)
}

class InstallationBottomSheet: BaseNonNavigationController {
    
    @IBOutlet weak var dismissAreaView: UIView!
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerTextFieldView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var data: [InstallationData] = []
    var filteredData: [InstallationData] = []
    weak var delegate: InstallationBottomSheetDelegate?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.showBottomSheet()
        self.configureKeyboard()
        self.filteredData = self.data
    }
    
}

extension InstallationBottomSheet {
    
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
        self.containerTextFieldView.makeCornerRadius(8)
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

extension InstallationBottomSheet: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectionTVC.identifier, for: indexPath) as? SelectionTVC
        else {
            return UITableViewCell()
        }
        
        let groupedData = self.filteredData[indexPath.row]
        cell.setupCell(title: groupedData.name ?? "", description: groupedData.groupName, type: .withDesc)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let delegate else { return }
        self.dismissBottomSheet() {
            delegate.didSelectInstallation(self.filteredData[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension InstallationBottomSheet: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if text.isEmpty {
            self.filteredData = self.data
        } else {
            self.filteredData = self.data.filter { $0.name?.contains(text.lowercased()) ?? false }
        }
        self.tableView.reloadData()
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.filteredData = self.data
        self.tableView.reloadData()
        return true
    }
    
}
