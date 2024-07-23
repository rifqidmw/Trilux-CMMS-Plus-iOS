//
//  SelectTechnicianBottomSheet.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 14/06/24.
//

import UIKit
import Combine

class SelectTechnicianBottomSheet: BaseNonNavigationController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dismissAreaView: UIView!
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    @IBOutlet weak var selectAllButton: UILabel!
    @IBOutlet weak var containerTextFieldView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: GeneralButton!
    
    weak var delegate: SelectTechnicianBottomSheetDelegate?
    var type: SelectTechnicianBottomSheetType?
    var filteredData: [TechnicianEntity] = []
    var data: [TechnicianEntity] = []
    var selectedTechnicians: Set<TechnicianEntity> = []
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.showBottomSheet()
        self.filteredData = data
    }
    
}

extension SelectTechnicianBottomSheet {
    
    private func setupBody() {
        setupView()
        setupAction()
        setupTableView()
        setupTextField()
    }
    
    private func setupView() {
        bottomSheetView.configure(type: .withoutHandleBar)
        containerTextFieldView.makeCornerRadius(8)
        addButton.makeCornerRadius(8)
        
        switch self.type {
        case .selectOne:
            textField.placeholder = "Cari Teknisi yang diinginkan"
            titleLabel.text = "Pilih Teknisi"
        case .selectMultiple:
            textField.placeholder = "Cari Pendamping yang diinginkan"
            titleLabel.text = "Pilih Pendamping"
            addButton.configure(title: "Tambah")
            selectAllButton.isHidden = true
            addButton.isHidden = false
        default: break
        }
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SelectTechnicialCell.nib, forCellReuseIdentifier: SelectTechnicialCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
    }
    
    private func setupAction() {
        Publishers.Merge(bottomSheetView.handleBarArea.gesture(), dismissAreaView.gesture())
            .sink { [weak self] _ in
                guard let self else { return }
                self.dismissBottomSheet()
            }
            .store(in: &anyCancellable)
        
        addButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let delegate = self.delegate
                else { return }
                self.dismissBottomSheet() {
                    delegate.selectMultipleTechnician(Array(self.selectedTechnicians))
                }
            }
            .store(in: &anyCancellable)
    }
    
    private func filterData(with query: String) {
        if query.isEmpty {
            filteredData = data
        } else {
            filteredData = data.filter { $0.name?.lowercased().contains(query.lowercased()) ?? false }
        }
        tableView.reloadData()
    }
    
    private func setupTextField() {
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        filterData(with: textField.text ?? "")
    }
    
}

extension SelectTechnicianBottomSheet: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectTechnicialCell.identifier, for: indexPath) as? SelectTechnicialCell,
              let type
        else {
            return UITableViewCell()
        }
        
        let technician = self.filteredData[indexPath.row]
        let isSelected = self.selectedTechnicians.contains(technician)
        cell.setupCell(data: technician, type: type, isSelected: isSelected)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let delegate = self.delegate else { return }
        switch self.type {
        case .selectOne:
            delegate.didSelectTechnician(self.filteredData[indexPath.row])
            self.dismissBottomSheet()
        case .selectMultiple:
            let technician = self.filteredData[indexPath.row]
            if self.selectedTechnicians.contains(technician) {
                self.selectedTechnicians.remove(technician)
            } else {
                self.selectedTechnicians.insert(technician)
            }
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        default: break
        }
    }
    
}
