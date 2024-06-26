//
//  LoadPreventiveRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 29/05/24.
//

import UIKit

class LoadPreventiveRouter: BaseRouter {
    
    func showView(data: WorkSheetListEntity) -> LoadPreventiveView {
        let interactor = LoadPreventiveInteractor()
        let presenter = LoadPreventivePresenter(interactor: interactor, router: self, data: data)
        let view = LoadPreventiveView(nibName: String(describing: LoadPreventiveView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}

extension LoadPreventiveRouter {
    
    func showBottomSheet(nav: UINavigationController, bottomSheetView: UIViewController) {
        bottomSheetView.loadViewIfNeeded()
        bottomSheetView.modalPresentationStyle = .overCurrentContext
        UIApplication.topViewController()?.present(bottomSheetView, animated: true, completion: nil)
    }
    
}
