//
//  AddComplaintBottomSheet.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 14/06/24.
//

import UIKit
import Combine

protocol AddComplaintBottomSheetDelegate: AnyObject {
    func didTapSelectTechnician(_ view: AddComplaintBottomSheet)
    func didTapSelectPartner(_ view: AddComplaintBottomSheet)
    func didTapSelectDate(_ view: AddComplaintBottomSheet)
    func didTapCreateAdvanceWorkSheet(_ view: AddComplaintBottomSheet, engineerId: String, complainId: String, dueDate: String, engineerPendamping: [String], title: CorrectiveTitleType)
}

class AddComplaintBottomSheet: BaseNonNavigationController {
    
    @IBOutlet weak var dismissAreaView: UIView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    @IBOutlet weak var containerAssetView: UIView!
    @IBOutlet weak var headerAssetView: CustomHeaderView!
    @IBOutlet weak var serialNumberView: InformationCardView!
    @IBOutlet weak var roomView: InformationCardView!
    
    @IBOutlet weak var containerTroubleView: UIView!
    @IBOutlet weak var headerTroubleView: CustomHeaderView!
    @IBOutlet weak var topicView: InformationCardView!
    @IBOutlet weak var chronologyView: InformationCardView!
    
    @IBOutlet weak var initialHeightTableViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var selectEngineerView: SelectView!
    @IBOutlet weak var selectPartnerView: SelectView!
    @IBOutlet weak var containerPartnerListStackView: UIStackView!
    @IBOutlet weak var deleteButton: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectDateView: SelectView!
    @IBOutlet weak var addButton: GeneralButton!
    
    weak var delegate: AddComplaintBottomSheetDelegate?
    var data: Complaint?
    var type: CorrectiveTitleType?
    var selectedTechnician: TechnicianEntity?
    var selectedPartner: [TechnicianEntity] = []
    var selectedPartnersToDelete: Set<TechnicianEntity> = []
    var selectedDate: Date?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateSelectedValues()
    }
    
}

extension AddComplaintBottomSheet {
    
    private func setupBody() {
        setupView()
        setupAction()
        setupTableView()
        updateSelectedValues()
    }
    
    private func setupView() {
        guard let data else { return }
        bottomSheetView.configure(type: .withoutHandleBar)
        
        containerAssetView.makeCornerRadius(8)
        containerAssetView.addShadow(2, opacity: 0.2)
        headerAssetView.configure(icon: "ic_notes_board",title: data.valEquipmentName ?? "-", type: .plain)
        serialNumberView.configureView(title: "Serial Number", value: data.txtEquipmentSerial ?? "-")
        roomView.configureView(title: "Ruangan", value: data.txtRuangan ?? "-")
        
        containerTroubleView.makeCornerRadius(8)
        containerTroubleView.addShadow(2, opacity: 0.2)
        headerTroubleView.configure(icon: "ic_document_trouble",title: "Permasalahan", type: .plain)
        topicView.configureView(title: "Topik Kerusakan", value: data.txtTitle ?? "-")
        chronologyView.configureView(title: "Kronologi Kerusakan", value: data.txtDescriptions ?? "-")
        addButton.configure(title: "Tambah")
        
        containerPartnerListStackView.makeCornerRadius(8)
        selectEngineerView.configure(title: "Teknisi", placeHolder: "Pilih Teknisi")
        selectPartnerView.configure(title: "Pendamping", placeHolder: "Pilih Pendamping")
        selectDateView.configure(title: "Terjadwal Tanggal", placeHolder: String.getCurrentDateString("dd-MM-yyyy"), type: .date)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            UIView.animate(withDuration: 0.2, animations: {
                self.dismissAreaView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            })
        }
    }
    
    private func setupAction() {
        addButton.gesture()
            .sink { [weak self] _ in
                guard let self = self,
                      let delegate = self.delegate,
                      let engineerId = self.selectedTechnician?.id,
                      let data = self.data else { return }
                
                let dateSelected = self.selectedDate ?? Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                let dateString = formatter.string(from: dateSelected)
                let engineerPendamping = self.selectedPartner.compactMap { $0.id }
                
                delegate.didTapCreateAdvanceWorkSheet(
                    self,
                    engineerId: engineerId,
                    complainId: String(data.id ?? 0),
                    dueDate: dateString,
                    engineerPendamping: engineerPendamping,
                    title: self.type ?? .none
                )
            }
            .store(in: &anyCancellable)
        
        selectEngineerView.gesture()
            .sink { [weak self] _ in
                guard let self, let delegate = self.delegate else { return }
                delegate.didTapSelectTechnician(self)
            }
            .store(in: &anyCancellable)
        
        selectPartnerView.gesture()
            .sink { [weak self] _ in
                guard let self, let delegate = self.delegate else { return }
                delegate.didTapSelectPartner(self)
            }
            .store(in: &anyCancellable)
        
        selectDateView.gesture()
            .sink { [weak self] _ in
                guard let self, let delegate = self.delegate else { return }
                delegate.didTapSelectDate(self)
            }
            .store(in: &anyCancellable)
        
        deleteButton.gesture()
            .sink { [weak self] _ in
                guard let self else { return }
                self.deleteSelectedTechnicians()
            }
            .store(in: &anyCancellable)
        
        
        Publishers.Merge3(bottomSheetView.handleBarArea.gesture(), titleView.gesture(), dismissAreaView.gesture())
            .sink { [weak self] _ in
                guard let self else { return }
                self.dismissBottomSheet()
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
    
    func updateSelectedValues() {
        self.tableView.reloadData()
        calculateTotalHeight(for: self.tableView)
        selectEngineerView.configure(title: "Teknisi", placeHolder: "Pilih Teknisi", value: selectedTechnician?.name ?? "")
        if !selectedPartner.isEmpty {
            self.containerPartnerListStackView.isHidden = false
        } else {
            self.containerPartnerListStackView.isHidden = true
        }
        if let selectedDate = selectedDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.dateFormat = "dd-MM-yyyy"
            selectDateView.configure(title: "Terjadwal Tanggal", placeHolder: String.getCurrentDateString("dd-MM-yyyy"), value: dateFormatter.string(from: selectedDate), type: .date)
        }
    }
    
    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(PartnerCell.nib, forCellReuseIdentifier: PartnerCell.identifier)
        self.tableView.separatorStyle = .none
        self.calculateTotalHeight(for: self.tableView)
    }
    
    private func deleteSelectedTechnicians() {
        selectedPartner.removeAll { $0.isSelected }
        updateSelectedValues()
    }
    
}

extension AddComplaintBottomSheet: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectedPartner.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PartnerCell.identifier, for: indexPath) as? PartnerCell else {
            return UITableViewCell()
        }
        
        cell.setupCell(data: self.selectedPartner[indexPath.row], order: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func calculateTotalHeight(for tableView: UITableView) {
        var totalHeight: CGFloat = 0
        for row in 0..<tableView.numberOfRows(inSection: 0) {
            let indexPath = IndexPath(row: row, section: 0)
            totalHeight += tableView.rectForRow(at: indexPath).height
        }
        initialHeightTableViewConstraint.constant = totalHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPartner[indexPath.row].isSelected.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
}
