//
//  ConfirmExitBottomSheet.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 07/08/24.
//

import UIKit
import Combine

protocol ConfirmExitBottomSheetDelegate: AnyObject {
    func didTapExitWorkSheet()
}

class ConfirmExitBottomSheet: BaseNonNavigationController {
    
    @IBOutlet var popUpView: BasePopUpView!
    weak var delegate: ConfirmExitBottomSheetDelegate?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.showBottomSheet()
    }
    
}

extension ConfirmExitBottomSheet {
    
    private func setupBody() {
        setupView()
        setupAction()
    }
    
    private func setupView() {
        popUpView.configureView(icon: "ic_warning_ellipse", title: "Konfirmasi keluar dari halaman ini?", leftButtonTitle: "Tidak", rightButtonTitle: "Ya")
    }
    
    private func setupAction() {
        popUpView.cancelButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let delegate = self.delegate
                else { return }
                self.dismissBottomSheet() {
                    delegate.didTapExitWorkSheet()
                }
            }
            .store(in: &anyCancellable)
        
        Publishers.Merge3(
            popUpView.agreeButton.gesture(),
            popUpView.bottomSheetView.handleBarArea.gesture(),
            popUpView.dismissAreaView.gesture())
        .sink { [weak self] _ in
            guard let self else { return }
            self.dismissBottomSheet()
        }
        .store(in: &anyCancellable)
    }
    
}
