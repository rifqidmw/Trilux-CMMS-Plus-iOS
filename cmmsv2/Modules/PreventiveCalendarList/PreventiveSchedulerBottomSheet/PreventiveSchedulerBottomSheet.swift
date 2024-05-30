//
//  PreventiveSchedulerBottomSheet.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 30/05/24.
//

import UIKit
import Combine

protocol PreventiveSchedulerBottomSheetDelegate: AnyObject {
    func didTapCreatePreventive()
}

class PreventiveSchedulerBottomSheet: BaseNonNavigationController {
    
    @IBOutlet var popUpView: BasePopUpView!
    weak var delegate: PreventiveSchedulerBottomSheetDelegate?
    
    override func didLoad() {
        super.didLoad()
        setupBody()
    }
    
}

extension PreventiveSchedulerBottomSheet {
    
    private func setupBody() {
        setupView()
        setupAction()
    }
    
    private func setupView() {
        popUpView.configureView(icon: "ic_calendar_with_wrench", title: "Jadwalkan Preventif", firstMessage: "Apakah Anda yakin ingin ", boldText: "menambahkan", secondMessage: " jadwal preventif untuk alat ini?", leftButtonTitle: "Tidak", rightButtonTitle: "Ya")
    }
    
    private func setupAction() {
        popUpView.cancelButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let delegate = self.delegate
                else { return }
                
                delegate.didTapCreatePreventive()
            }
            .store(in: &anyCancellable)
        
        Publishers.Merge3(
            popUpView.agreeButton.gesture(),
            popUpView.bottomSheetView.handleBarArea.gesture(),
            popUpView.dismissAreaView.gesture())
        .sink { [weak self] _ in
            guard let self else { return }
            self.dismiss(animated: true)
        }
        .store(in: &anyCancellable)
    }
    
}
