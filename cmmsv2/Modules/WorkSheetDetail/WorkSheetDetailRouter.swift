// 
//  WorkSheetDetailRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 21/01/24.
//

import UIKit

class WorkSheetDetailRouter: BaseRouter {
    
    func showView() -> WorkSheetDetailView {
        let interactor = WorkSheetDetailInteractor()
        let presenter = WorkSheetDetailPresenter(interactor: interactor)
        let view = WorkSheetDetailView(nibName: String(describing: WorkSheetDetailView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}

extension WorkSheetDetailRouter {
    
    func goToFullScreenPicture(navigation: UINavigationController, titlePage: String, image: String) {
        let vc = FullScreenPictureRouter().showView()
        vc.titlePage = titlePage
        vc.image = image
        navigation.pushViewController(vc, animated: true)
    }
    
    func showAllEvidenceBottomSheet(navigation: UINavigationController) {
        let bottomSheet = AllEvidenceBottomSheet(nibName: String(describing: AllEvidenceBottomSheet.self), bundle: nil)
        bottomSheet.modalPresentationStyle = .overCurrentContext
        navigation.present(bottomSheet, animated: true)
    }
    
}
