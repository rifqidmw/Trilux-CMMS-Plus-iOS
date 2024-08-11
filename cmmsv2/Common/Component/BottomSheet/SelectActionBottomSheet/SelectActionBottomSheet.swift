//
//  SelectActionBottomSheet.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 22/01/24.
//

import UIKit
import Combine

@objc protocol WorkSheetOnsitePreventiveDelegate: AnyObject {
    @objc optional func didTapDetail(title: String)
    @objc optional func didTapContinueWorking(title: String)
    @objc optional func didTapDownloadPDF()
    @objc optional func didTapCorrection(title: String)
}

class SelectActionBottomSheet: BaseNonNavigationController {
    
    @IBOutlet weak var dismissAreaView: UIView!
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    @IBOutlet weak var workButton: GeneralButton!
    @IBOutlet weak var correctionButton: GeneralButton!
    @IBOutlet weak var seeDetailButton: GeneralButton!
    @IBOutlet weak var downloadPDFButton: GeneralButton!
    
    weak var delegate: WorkSheetOnsitePreventiveDelegate?
    var type: WorkSheetStatus?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.showBottomSheet()
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
        correctionButton.configure(title: "Koreksi", backgroundColor: UIColor.customIndicatorColor2, titleColor: UIColor.customIndicatorColor11)
        
        guard let type = type else { return }
        
        switch type {
        case .done:
            workButton.isHidden = true
            correctionButton.isHidden = true
        case .ongoing, .open:
            correctionButton.isHidden = true
        default:
            break
        }
    }
    
    private func setupAction() {
        Publishers.Merge(
            bottomSheetView.handleBarArea.gesture(),
            dismissAreaView.gesture())
        .sink { [weak self] _ in
            guard let self else { return }
            self.dismissBottomSheet()
        }
        .store(in: &anyCancellable)
        
        workButton.gesture()
            .sink { [weak self] _ in
                guard let self, let delegate = self.delegate else { return }
                self.dismissBottomSheet() {
                    delegate.didTapContinueWorking?(title: "kerjakan")
                }
            }
            .store(in: &anyCancellable)
        
        seeDetailButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let delegate = self.delegate
                else { return }
                self.dismissBottomSheet() {
                    delegate.didTapDetail?(title: "lihat")
                }
            }
            .store(in: &anyCancellable)
        
        downloadPDFButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let delegate
                else { return }
                self.dismissBottomSheet() {
                    delegate.didTapDownloadPDF?()
                }
            }
            .store(in: &anyCancellable)
        
        correctionButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let delegate
                else { return }
                self.dismissBottomSheet() {
                    delegate.didTapCorrection?(title: "koreksi")
                }
            }
            .store(in: &anyCancellable)
    }
    
}
