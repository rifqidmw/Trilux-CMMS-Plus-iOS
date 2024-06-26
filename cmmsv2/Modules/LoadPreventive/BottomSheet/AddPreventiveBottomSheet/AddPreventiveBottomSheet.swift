//
//  AddPreventiveBottomSheet.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 30/05/24.
//

import UIKit
import Combine

class AddPreventiveBottomSheet: BaseNonNavigationController {
    
    @IBOutlet weak var dismissAreaView: UIView!
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    @IBOutlet weak var containerAssetView: UIView!
    @IBOutlet weak var containerAssetHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var customHeaderView: CustomHeaderView!
    @IBOutlet weak var serialNumberView: InformationCardView!
    @IBOutlet weak var brandView: InformationCardView!
    @IBOutlet weak var typeView: InformationCardView!
    @IBOutlet weak var installationView: InformationCardView!
    @IBOutlet weak var roomView: InformationCardView!
    @IBOutlet weak var containerSelectCategoryView: UIView!
    @IBOutlet weak var containerSelectCategoryHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveButton: GeneralButton!
    
    private var selectedCategoryIndex: Int?
    weak var delegate: AddPreventiveBottomSheetDelegate?
    var selectedDate: String?
    var selectedMonth: String?
    var data: LoadPreventiveAsset?
    var categoryData: [PreventiveCategoryEntity] = [
        PreventiveCategoryEntity(title: "Penjadwalan",
                                 description: "Lakukan penjadwalan preventif pada tanggal tertentu",
                                 selectDateTitle: "Pilih Tanggal",
                                 selectDateTitlePlaceHolder: "Pilih Tanggal"),
        PreventiveCategoryEntity(title: "Perencanaan",
                                 description: "Lakukan perencanaan preventif pada bulan dan tahun tertentu",
                                 selectDateTitle: "Pilih Bulan",
                                 selectDateTitlePlaceHolder: "Pilih Bulan")
    ]
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.showBottomSheet()
    }
    
}

extension AddPreventiveBottomSheet {
    
    private func setupBody() {
        setupView()
        setupAction()
        setupTableView()
    }
    
    private func setupView() {
        guard let asset = self.data else { return }
        containerAssetView.makeCornerRadius(8)
        containerAssetView.addShadow(0.4)
        customHeaderView.configure(icon: "ic_notes_board", title: asset.txtName ?? "", type: .plain)
        serialNumberView.configureView(title: "Serial Number", value: asset.txtSerial ?? "")
        brandView.configureView(title: "Merk", value: asset.txtBrand ?? "")
        typeView.configureView(title: "Tipe", value: asset.txtType ?? "")
        installationView.configureView(title: "Instalasi", value: asset.txtLokasiInstalasi ?? "")
        roomView.configureView(title: "Ruangan", value: asset.txtRuangan ?? "")
        
        containerSelectCategoryView.makeCornerRadius(8)
        containerSelectCategoryView.addShadow(0.4)
        saveButton.configure(title: "Simpan")
    }
    
    private func setupAction() {
        Publishers.Merge(bottomSheetView.handleBarArea.gesture(), dismissAreaView.gesture())
            .sink { [weak self] _ in
                guard let self else { return }
                self.dismissBottomSheet()
            }
            .store(in: &anyCancellable)
        
        saveButton.gesture()
            .sink { [weak self] _ in
                guard let self else { return }
            }
            .store(in: &anyCancellable)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PreventiveCategoryTVC.nib, forCellReuseIdentifier: PreventiveCategoryTVC.identifier)
        tableView.separatorStyle = .none
        updateSelectedData()
    }
    
    func updateSelectedData() {
        if let selectedDate = self.selectedDate {
            self.categoryData[0].selectedDate = selectedDate
        }
        
        if let selectedMonth = self.selectedMonth {
            self.categoryData[1].selectedMonth = selectedMonth
        }
        
        self.tableView.reloadData()
    }
    
}

extension AddPreventiveBottomSheet: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categoryData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PreventiveCategoryTVC.identifier, for: indexPath) as? PreventiveCategoryTVC
        else {
            return UITableViewCell()
        }
        
        cell.setupCell(data: self.categoryData[indexPath.row], delegate: self, index: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for index in categoryData.indices {
            categoryData[index].isSelected = (index == indexPath.row)
        }
        selectedCategoryIndex = indexPath.row
        tableView.reloadData()
    }
    
}

extension AddPreventiveBottomSheet: PreventiveCategoryCellDelegate {
    
    func didTapSelectDate(index: Int) {
        guard let delegate else { return }
        if index == 0 {
            if selectedCategoryIndex == 1 {
                self.showAlert(title: "Peringatan", message: "Anda harus memilih Penjadwalan terlebih dahulu.")
            } else {
                delegate.didTapScheduling(from: self)
            }
        } else if index == 1 {
            if selectedCategoryIndex == 0 {
                self.showAlert(title: "Peringatan", message: "Anda harus memilih Perencanaan terlebih dahulu.")
            } else {
                delegate.didTapPlanning(from: self)
            }
        }
    }
    
}
