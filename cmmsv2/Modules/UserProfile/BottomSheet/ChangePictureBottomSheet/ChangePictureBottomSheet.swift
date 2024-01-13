//
//  ChangePictureBottomSheet.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 14/01/24.
//

import UIKit

class ChangePictureBottomSheet: BaseNonNavigationController {
    
    @IBOutlet var menuCardView: MenuCardView!
    
    override func didLoad() {
        super.didLoad()
        setupBody()
    }
    
}

extension ChangePictureBottomSheet {
    
    private func setupBody() {
        setupView()
        setupAction()
    }
    
    private func setupView() {
        menuCardView.configureTitle(title: "Ganti Gambar")
        menuCardView.data = changePictureData
        menuCardView.bottomSheetHeightConstraint.constant = 220
    }
    
    private func setupAction() {
        menuCardView.bottomSheetView.handleBarArea.gesture()
            .sink { [weak self] _ in
                guard let self else { return }
                self.dismiss(animated: true)
            }
            .store(in: &anyCancellable)
    }
    
}
