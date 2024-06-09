//
//  WorkSheetPreviewBottomSheet.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 21/01/24.
//

import UIKit
import Combine

class WorkSheetCorrectiveBottomSheet: BaseNonNavigationController {
    
    @IBOutlet weak var dismissAreaView: UIView!
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    @IBOutlet weak var imageCardView: ImageCardView!
    @IBOutlet weak var serialNumberView: InformationCardView!
    @IBOutlet weak var roomView: InformationCardView!
    @IBOutlet weak var brandView: InformationCardView!
    @IBOutlet weak var typeView: InformationCardView!
    @IBOutlet weak var reporterView: InformationCardView!
    @IBOutlet weak var chronologyView: InformationCardView!
    @IBOutlet weak var workButton: GeneralButton!
    @IBOutlet weak var resumeWorkButton: GeneralButton!
    @IBOutlet weak var seeWorkButton: GeneralButton!
    @IBOutlet weak var seeDetailButton: GeneralButton!
    @IBOutlet weak var dismissButton: UIView!
    
    weak var delegate: WorkSheetCorrectiveBottomSheetDelegate?
    var data: WorkOrder?
    
    override func didLoad() {
        super.didLoad()
        setupBody()
    }
    
}

extension WorkSheetCorrectiveBottomSheet {
    
    private func setupBody() {
        setupView()
        setupAction()
        configureSharedComponent()
    }
    
    private func setupView() {
        guard let data,
              let complain = data.complain,
              let equipment = complain.equipment
        else { return }
        
        imageCardView.configureView(image: equipment.valImage ?? "", label: equipment.txtName ?? "")
        serialNumberView.configureView(title: "Serial Number", value: equipment.txtSerial ?? "")
        roomView.configureView(title: "Ruangan", value: equipment.txtRuangan ?? "")
        brandView.configureView(title: "Merk", value: equipment.txtBrand ?? "")
        typeView.configureView(title: "Tipe", value: equipment.txtBrand ?? "")
        reporterView.configureView(title: "Pengaduan dilakukan oleh", value: complain.txtTitle ?? "")
        chronologyView.configureView(title: "Kronologi", value: complain.txtDescriptions ?? "")
    }
    
    private func configureSharedComponent() {
        workButton.configure(title: "Kerjakan", type: .borderedWithIcon, icon: "ic_scan_gray", titleColor: UIColor.customPlaceholderColor)
        resumeWorkButton.configure(title: "Lanjutkan Pekerjaan", type: .normal, backgroundColor: UIColor.customLightYellowColor, titleColor: UIColor.customDarkYellowColor)
        seeWorkButton.configure(title: "Lihat Pekerjaan", type: .normal, backgroundColor: UIColor.customLightGreenColor, titleColor: UIColor.customGreenColor)
        seeDetailButton.configure(title: "Lihat")
    }
    
    private func setupAction() {
        Publishers.Merge3(
            bottomSheetView.handleBarArea.gesture(),
            dismissAreaView.gesture(),
            dismissButton.gesture())
        .sink { [weak self] _ in
            guard let self else { return }
            self.dismiss(animated: true)
        }
        .store(in: &anyCancellable)
        
        seeDetailButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let delegate,
                      let data
                else { return }
                delegate.didTapDetailCorrective(data: data)
            }
            .store(in: &anyCancellable)
    }
    
}
