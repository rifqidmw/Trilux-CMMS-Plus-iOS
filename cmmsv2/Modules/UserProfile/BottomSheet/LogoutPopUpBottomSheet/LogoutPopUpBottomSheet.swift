//
//  LogoutPopUpBottomSheetView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 14/01/24.
//

import Combine
import UIKit

protocol LogoutPopUpBottomSheetDelegate: AnyObject {
    func didTapLogout()
}

class LogoutPopUpBottomSheet: BaseNonNavigationController {
    
    @IBOutlet var popUpView: BasePopUpView!
    weak var delegate: LogoutPopUpBottomSheetDelegate?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.showBottomSheet()
    }
    
}

extension LogoutPopUpBottomSheet {
    
    private func setupBody() {
        setupView()
        setupAction()
    }
    
    private func setupView() {
        popUpView.configureView(icon: "ic_door_leave_circle", title: "Konfirmasi Keluar", firstMessage: "Apakah Anda yakin untuk ", boldText: "Keluar ", secondMessage: "dari aplikasi?", leftButtonTitle: "Ya, Keluar", rightButtonTitle: "Tidak")
    }
    
    private func setupAction() {
        popUpView.agreeButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let delegate = self.delegate
                else { return }
                delegate.didTapLogout()
            }
            .store(in: &anyCancellable)
        
        Publishers.Merge3(
            popUpView.cancelButton.gesture(),
            popUpView.bottomSheetView.handleBarArea.gesture(),
            popUpView.dismissAreaView.gesture())
        .sink { [weak self] _ in
            guard let self else { return }
            self.dismissBottomSheet()
        }
        .store(in: &anyCancellable)
    }
    
}
