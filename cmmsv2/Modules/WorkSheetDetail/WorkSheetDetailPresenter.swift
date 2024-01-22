// 
//  WorkSheetDetailPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 21/01/24.
//

import UIKit

class WorkSheetDetailPresenter: BasePresenter {
    
    private let interactor: WorkSheetDetailInteractor
    private let router = WorkSheetDetailRouter()
    
    init(interactor: WorkSheetDetailInteractor) {
        self.interactor = interactor
    }
    
}

extension WorkSheetDetailPresenter {
    
    func navigateToWorkSheetList() {
        router.goBackToWorkSheetList()
    }
    
    func navigateToFullScreenPicture(navigation: UINavigationController, titlePage: String, image: String) {
        router.goToFullScreenPicture(navigation: navigation, titlePage: titlePage, image: image)
    }
    
    func showBottomSheetAllEvidence(navigation: UINavigationController) {
        router.showAllEvidenceBottomSheet(navigation: navigation)
    }
    
}
