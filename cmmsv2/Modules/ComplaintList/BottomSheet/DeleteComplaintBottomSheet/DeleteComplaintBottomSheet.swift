//
//  DeleteComplaintBottomSheet.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 19/08/24.
//

import UIKit
import Combine

protocol DeleteComplaintBottomSheetDelegate: AnyObject {
    func didDeleteLk(data: Complaint)
}

class DeleteComplaintBottomSheet: BaseNonNavigationController {
    
    @IBOutlet var popUpView: BasePopUpView!
    var data: Complaint?
    weak var delegate: DeleteComplaintBottomSheetDelegate?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.showBottomSheet()
    }
    
}

extension DeleteComplaintBottomSheet {
    
    private func setupBody() {
        setupView()
        setupAction()
    }
    
    private func setupView() {
        popUpView.configureView(
            icon: "ic_trash_red_circle",
            title: "Konfirmasi Hapus Delegasi LK",
            firstMessage: "Apakah anda yakin untuk ",
            boldText: "menghapus", 
            secondMessage: " delegasi lembar kerja ini?",
            leftButtonTitle: "Tidak",
            rightButtonTitle: "Ya, Hapus")
    }
    
    private func setupAction() {
        popUpView.cancelButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let delegate = self.delegate,
                      let data
                else { return }
                self.dismissBottomSheet() {
                    delegate.didDeleteLk(data: data)
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
