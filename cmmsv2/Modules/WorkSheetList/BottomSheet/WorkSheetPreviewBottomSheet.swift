//
//  WorkSheetPreviewBottomSheet.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 21/01/24.
//

import UIKit

class WorkSheetPreviewBottomSheet: BaseNonNavigationController {
    
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
    
    var data: WorkSheetListEntity?
    
    override func didLoad() {
        super.didLoad()
        setupBody()
    }
    
}

extension WorkSheetPreviewBottomSheet {
    
    private func setupBody() {
        setupView()
        setupAction()
    }
    
    private func setupView() {
        imageCardView.configureView(image: "unsplash_yo01Z-9HQAw", label: "Steril Pouch (Sterilization Pack)")
        serialNumberView.configureView(title: "Serial Number", value: "112234452537")
        roomView.configureView(title: "Ruangan", value: "Poliklinik Executive Cendana")
        brandView.configureView(title: "Merk", value: "B Braun")
        typeView.configureView(title: "Tipe", value: "NE-C28")
        reporterView.configureView(title: "Pengaduan dilakukan oleh", value: "Andini")
        chronologyView.configureView(title: "Kronologi", value: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever")
        workButton.configure(title: "Kerjakan", type: .borderedWithIcon, icon: "ic_scan_gray", titleColor: UIColor.customPlaceholderColor)
        resumeWorkButton.configure(title: "Lanjutkan Pekerjaan", type: .normal, backgroundColor: UIColor.customLightYellowColor, titleColor: UIColor.customDarkYellowColor)
        seeWorkButton.configure(title: "Lihat Pekerjaan", type: .normal, backgroundColor: UIColor.customLightGreenColor, titleColor: UIColor.customGreenColor)
        seeDetailButton.configure(title: "Lihat")
    }
    
    private func setupAction() {
        dismissAreaView.gesture()
            .sink { [weak self] _ in
                guard let self else { return }
                self.dismiss(animated: true)
            }
            .store(in: &anyCancellable)
        
        bottomSheetView.handleBarArea.gesture()
            .sink { [weak self] _ in
                guard let self else { return }
                self.dismiss(animated: true)
            }
            .store(in: &anyCancellable)
        
        seeDetailButton.gesture()
            .sink { [weak self] _ in
                guard self != nil else { return }
                let vc = WorkSheetDetailRouter().showView()
                let rootViewController = UINavigationController(rootViewController: vc)
                UIApplication.shared.windows.first?.rootViewController = rootViewController
            }
            .store(in: &anyCancellable)
    }
    
}
