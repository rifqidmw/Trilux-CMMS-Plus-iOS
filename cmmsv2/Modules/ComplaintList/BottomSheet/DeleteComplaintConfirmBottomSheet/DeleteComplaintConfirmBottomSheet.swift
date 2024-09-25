//
//  DeleteComplaintConfirmBottomSheet.swift
//  cmmsv2
//
//  Created by macbook  on 22/09/24.
//

import UIKit
import Combine

protocol DeleteComplaintConfirmBottomSheetDelegate: AnyObject {
    func didConfirmationDeleteComplaint(_ id: String?)
}

class DeleteComplaintConfirmBottomSheet: BaseNonNavigationController {
    
    @IBOutlet var popUpView: BasePopUpView!
    
    weak var delegate: DeleteComplaintConfirmBottomSheetDelegate?
    var id: String?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.showBottomSheet()
    }
    
}

extension DeleteComplaintConfirmBottomSheet {
    
    private func setupBody() {
        setupView()
        setupAction()
    }
    
    private func setupView() {
        popUpView.configureView(
            icon: "ic_trash_red_circle",
            title: "Konfirmasi Hapus",
            firstMessage: "Apakah Anda yakin untuk menghapus data pengaduan ini?",
            leftButtonTitle: "Tidak",
            rightButtonTitle: "Ya, Hapus")
    }
    
    private func setupAction() {
        popUpView.cancelButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let delegate = self.delegate
                else { return }
                self.dismissBottomSheet() {
                    delegate.didConfirmationDeleteComplaint(self.id ?? "")
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
