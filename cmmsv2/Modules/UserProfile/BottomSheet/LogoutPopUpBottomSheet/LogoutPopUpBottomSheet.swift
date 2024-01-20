//
//  LogoutPopUpBottomSheetView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 14/01/24.
//

import UIKit

class LogoutPopUpBottomSheet: BaseNonNavigationController {
    
    @IBOutlet var popUpView: BasePopUpView!
    
    override func didLoad() {
        super.didLoad()
        setupBody()
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
                guard self != nil else { return}
                AppLogger.log("TO DO LOGOUT")
            }
            .store(in: &anyCancellable)
        
        popUpView.cancelButton.gesture()
            .sink { [weak self] _ in
                guard let self else { return }
                self.dismiss(animated: true)
            }
            .store(in: &anyCancellable)
        
        popUpView.bottomSheetView.handleBarArea.gesture()
            .sink { [weak self] _ in
                guard let self else { return }
                self.dismiss(animated: true)
            }
            .store(in: &anyCancellable)
        
        popUpView.dismissAreaView.gesture()
            .sink { [weak self] _ in
                guard let self else { return }
                self.dismiss(animated: true)
            }
            .store(in: &anyCancellable)
    }
    
}
