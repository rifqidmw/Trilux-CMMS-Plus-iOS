//
//  NotificationDetailBottomSheet.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 04/03/24.
//

import UIKit

protocol NotificationDetailBottomSheetDelegate: AnyObject {
    func didTapCompanionButton()
    func didTapDetailButton()
    func didTapDownloadPDFButton()
}

class NotificationDetailBottomSheet: BaseNonNavigationController {
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    @IBOutlet weak var handleBarView: UIView!
    @IBOutlet weak var headerSectionView: UIView!
    @IBOutlet weak var headerSectionImageView: UIImageView!
    @IBOutlet weak var headerTitleLabel: UILabel!
    
    @IBOutlet weak var workSheetNumberView: InformationCardView!
    @IBOutlet weak var leadTechnicianView: InformationCardView!
    @IBOutlet weak var technicianView: InformationCardView!
    @IBOutlet weak var typeView: InformationCardView!
    @IBOutlet weak var delegationDateView: InformationCardView!
    
    @IBOutlet weak var serialNumberView: InformationCardView!
    @IBOutlet weak var roomView: InformationCardView!
    @IBOutlet weak var brandView: InformationCardView!
    @IBOutlet weak var inventoryNumberView: InformationCardView!
    
    @IBOutlet weak var complaintByView: InformationCardView!
    @IBOutlet weak var dateComplaintView: InformationCardView!
    @IBOutlet weak var chronologyView: InformationCardView!
    @IBOutlet weak var companionButton: GeneralButton!
    
    @IBOutlet weak var seeDetailButton: GeneralButton!
    @IBOutlet weak var downloadPDFButton: GeneralButton!
    
    weak var delegate: NotificationDetailBottomSheetDelegate?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
    }
    
}

extension NotificationDetailBottomSheet {
    
    private func setupBody() {
        setupView()
        setupAction()
    }
    
    private func setupView() {
        headerSectionView.makeCornerRadius(12)
        headerSectionView.addShadow(0.2, opacity: 0.2)
        headerSectionImageView.makeCornerRadius(12)
        
        companionButton.configure(title: "Anda Sebagai Pendamping", backgroundColor: UIColor.customLightGrayColor, titleColor: UIColor.customPrimaryColor)
        companionButton.makeCornerRadius(4)
        seeDetailButton.configure(title: "Lihat Detail")
        seeDetailButton.makeCornerRadius(4)
        downloadPDFButton.configure(title: "Download PDF", backgroundColor: UIColor.customLightGreenColor, titleColor: UIColor.darkGreen)
        downloadPDFButton.makeCornerRadius(4)
        
        headerSectionImageView.loadImageUrl("")
        headerTitleLabel.text = ""
        
        workSheetNumberView.configureView(title: "Nomor Lembar Kerja", value: "")
        leadTechnicianView.configureView(title: "Teknisi Utama", value: "")
        technicianView.configureView(title: "Teknisi", value: "")
        typeView.configureView(title: "Tipe", value: "")
        delegationDateView.configureView(title: "Tanggal Delegasi", value: "")
        
        serialNumberView.configureView(title: "Serial Number", value: "")
        roomView.configureView(title: "Ruangan", value: "")
        brandView.configureView(title: "Merk", value: "")
        inventoryNumberView.configureView(title: "Nomor Inventaris", value: "")
        
        complaintByView.configureView(title: "Pengaduan dilakukan oleh", value: "")
        dateComplaintView.configureView(title: "Tanggal", value: "")
        chronologyView.configureView(title: "Kronologi", value: "")
    }
    
    private func setupAction() {
        companionButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let delegate = self.delegate
                else { return }
                delegate.didTapCompanionButton()
            }
            .store(in: &anyCancellable)
        
        seeDetailButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let delegate = self.delegate
                else { return }
                delegate.didTapDetailButton()
            }
            .store(in: &anyCancellable)
        
        downloadPDFButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let delegate = self.delegate
                else { return }
                delegate.didTapDownloadPDFButton()
            }
            .store(in: &anyCancellable)
        
        handleBarView.gesture()
            .sink { [weak self] _ in
                guard let self else { return }
                self.dismiss(animated: true)
                print("CLICKED")
            }
            .store(in: &anyCancellable)
    }
    
}
