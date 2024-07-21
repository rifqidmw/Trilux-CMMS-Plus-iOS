//
//  SparePartBottomSheet.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/07/24.
//

import UIKit
import Combine

enum SparePartBottomSheetType {
    case usage
    case requirement
}

protocol SparePartBottomSheetDelegate: AnyObject {
    func didSelectSparePart(_ sparepartName: String)
}

class SparePartBottomSheet: BaseNonNavigationController {
    
    @IBOutlet weak var dismissAreaView: UIView!
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerTextFieldView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var data: [SearchSparePartData] = []
    var filteredData: [SearchSparePartData] = []
    var type: SparePartBottomSheetType?
    weak var delegate: SparePartBottomSheetDelegate?
    
    override func didLoad() {
        super.didLoad()
        self.showBottomSheet()
        self.setupBody()
        self.filteredData = self.data
    }
    
}

extension SparePartBottomSheet {
    
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
        case .requirement:
            self.titleLabel.text = "Pilih Penggunaan Suku Cadang"
        case .usage:
            self.titleLabel.text = "Pilih Kebutuhan Suku Cadang"
        }
    }
    
    private func setupAction() {
        Publishers.Merge(dismissAreaView.gesture(),
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

extension SparePartBottomSheet: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectionTVC.identifier, for: indexPath) as? SelectionTVC
        else {
            return UITableViewCell()
        }
        
        cell.setupCell(title: self.filteredData[indexPath.row].name ?? "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let delegate else { return }
        self.dismissBottomSheet() {
            delegate.didSelectSparePart(self.filteredData[indexPath.row].name ?? "")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension SparePartBottomSheet: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if text.isEmpty {
            self.filteredData = self.data
        } else {
            self.filteredData = self.data.filter { $0.partname?.lowercased().contains(text.lowercased()) ?? false }
        }
        self.tableView.reloadData()
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.filteredData = self.data
        self.tableView.reloadData()
        return true
    }
    
}
