//
//  SelectActionBottomSheet.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 22/01/24.
//

import UIKit
import Combine

enum SelectActionBottomSheetType {
    case download
    case detail
}

class SelectActionBottomSheet: BaseNonNavigationController {
    
    @IBOutlet weak var dismissAreaView: UIView!
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    @IBOutlet weak var workButton: GeneralButton!
    @IBOutlet weak var seeDetailButton: GeneralButton!
    @IBOutlet weak var downloadPDFButton: GeneralButton!
    
    weak var delegate: WorkSheetOnsitePreventiveDelegate?
    var type: SelectActionBottomSheetType?
    
    override func didLoad() {
        super.didLoad()
        setupBody()
    }
    
}

extension SelectActionBottomSheet {
    
    private func setupBody() {
        setupView()
        setupAction()
    }
    
    private func setupView() {
        bottomSheetView.configure(type: .withoutHandleBar)
        workButton.configure(title: "Kerjakan", type: .bordered)
        seeDetailButton.configure(title: "Lihat")
        downloadPDFButton.configure(title: "Download PDF", backgroundColor: UIColor.customLightGreenColor, titleColor: UIColor.customIndicatorColor10)
        
        switch self.type {
        case .download: break
        case .detail:
            self.downloadPDFButton.isHidden = true
        default: break
        }
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
                delegate.didTapContinueWorking?()
            }
            .store(in: &anyCancellable)
        
        seeDetailButton.gesture()
            .sink { [weak self] _  in
                guard let self,
                      let delegate = self.delegate
                else { return }
                delegate.didTapDetail?()
            }
            .store(in: &anyCancellable)
        
        downloadPDFButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let delegate
                else { return }
                delegate.didTapDownloadPDF?()
            }
            .store(in: &anyCancellable)
    }
    
}
