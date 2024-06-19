//
//  AddComplaintBottomSheet.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 14/06/24.
//

import UIKit
import Combine

protocol AddComplaintBottomSheetDelegate: AnyObject {
    func didTapSelectTechnician()
    func didTapSelectPartner()
    func didTapSelectDate()
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
    
    @IBOutlet weak var selectEngineerView: SelectView!
    @IBOutlet weak var selectPartnerView: SelectView!
    @IBOutlet weak var selectDateView: SelectView!
    
    @IBOutlet weak var addButton: GeneralButton!
    
    weak var delegate: AddComplaintBottomSheetDelegate?
    var data: Complaint?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
    }
    
}

extension AddComplaintBottomSheet {
    
    private func setupBody() {
        setupView()
        setupAction()
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
        
        selectEngineerView.configure(title: "Teknisi", placeHolder: "Pilih Teknisi", value: "")
        selectPartnerView.configure(title: "Pendamping", placeHolder: "Pilih Pendamping", value: "")
        selectDateView.configure(title: "Terjadwal Tanggal", placeHolder: "Pilih Tanggal", value: "")
        
        addButton.configure(title: "Tambah")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.dismissAreaView.makeAnimation {
                self.dismissAreaView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            }
        }
    }
    
    private func setupAction() {
        addButton.gesture()
            .sink { [weak self] _ in
                guard self != nil else { return }
                AppLogger.log("-- CLICKED - ADD COMPLAINT")
            }
            .store(in: &anyCancellable)
        
        selectEngineerView.gesture()
            .sink { [weak self] _ in
                guard let self, let delegate = self.delegate else { return }
                delegate.didTapSelectTechnician()
            }
            .store(in: &anyCancellable)
        
        selectPartnerView.gesture()
            .sink { [weak self] _ in
                guard let self, let delegate = self.delegate else { return }
                delegate.didTapSelectPartner()
            }
            .store(in: &anyCancellable)
        
        selectDateView.gesture()
            .sink { [weak self] _ in
                guard let self, let delegate = self.delegate else { return }
                delegate.didTapSelectDate()
            }
            .store(in: &anyCancellable)
        
        
        Publishers.Merge3(bottomSheetView.handleBarArea.gesture(), titleView.gesture(), dismissAreaView.gesture())
            .sink { [weak self] _ in
                guard let self else { return }
                self.dismiss(animated: true)
            }
            .store(in: &anyCancellable)
    }
    
}
