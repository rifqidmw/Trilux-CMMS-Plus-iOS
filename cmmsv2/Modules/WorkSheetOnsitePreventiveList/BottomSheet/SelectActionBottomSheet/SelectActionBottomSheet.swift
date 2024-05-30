//
//  SelectActionBottomSheet.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 22/01/24.
//

import UIKit
import Combine

class SelectActionBottomSheet: BaseNonNavigationController {
    
    @IBOutlet weak var dismissAreaView: UIView!
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    @IBOutlet weak var workButton: GeneralButton!
    @IBOutlet weak var seeDetailButton: GeneralButton!
    @IBOutlet weak var downloadPDFButton: GeneralButton!
    
    weak var delegate: WorkSheetOnsitePreventiveDelegate?
    var type: WorkSheetStatus?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
    }
    
}

extension SelectActionBottomSheet {
    
    private func setupBody() {
        setupView()
        setupAction()
    }
    
    private func setupView() {
        workButton.configure(title: "Kerjakan", type: .bordered)
        seeDetailButton.configure(title: "Lihat")
        downloadPDFButton.configure(title: "Download PDF", backgroundColor: UIColor.customLightGreenColor, titleColor: UIColor.customIndicatorColor10)
        guard let type else { return }
        workButton.isHidden = type == .done
    }
    
    private func setupAction() {
        Publishers.Merge(
            bottomSheetView.handleBarArea.gesture(),
            dismissAreaView.gesture())
        .sink { [weak self] _  in
            guard let self else { return }
            self.dismiss(animated: true)
        }
        .store(in: &anyCancellable)
        
        workButton.gesture()
            .sink { [weak self] _  in
                guard let self,
                      let delegate = self.delegate
                else { return }
                delegate.didTapContinueWorking?(title: "kerjakan")
            }
            .store(in: &anyCancellable)
        
        seeDetailButton.gesture()
            .sink { [weak self] _  in
                guard let self,
                      let delegate = self.delegate
                else { return }
                delegate.didTapDetail?(title: "lihat")
            }
            .store(in: &anyCancellable)
        
        downloadPDFButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let delegate
                else { return }
                delegate.didTapDownloadPDF?(title: "download")
            }
            .store(in: &anyCancellable)
    }
    
}
