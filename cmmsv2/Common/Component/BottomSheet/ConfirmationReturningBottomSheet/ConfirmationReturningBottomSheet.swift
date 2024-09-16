//
//  ConfirmationReturningBottomSheet.swift
//  cmmsv2
//
//  Created by macbook  on 16/09/24.
//

import UIKit
import Combine

protocol ConfirmationReturningBottomDelegate: AnyObject {
    func didTapConfirm(_ idx: String)
}

enum ConfirmationReturningBottomSheetType {
    case delete
    case approve
}

class ConfirmationReturningBottomSheet: BaseNonNavigationController {
    
    @IBOutlet var popUpView: BasePopUpView!
    var id: String?
    var type: ConfirmationReturningBottomSheetType?
    weak var delegate: ConfirmationReturningBottomDelegate?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.showBottomSheet()
    }
    
}

extension ConfirmationReturningBottomSheet {
    
    private func setupBody() {
        setupView()
        setupAction()
    }
    
    private func setupView() {
        guard let type else { return }
        let isDeleteType = type == .delete
        popUpView.configureView(
            icon: isDeleteType ? "ic_trash_red_circle" : "ic_check_green_circle",
            title: isDeleteType ? "Konfirmasi Hapus" : "Setuju Relokasi Alat",
            firstMessage: isDeleteType ? "Apakah Anda yakin untuk menghapus data pinjaman alat ini?" : "Apakah Anda yakin untuk menyetujui relokasi alat ini?",
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
                    delegate.didTapConfirm(self.id ?? "")
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
