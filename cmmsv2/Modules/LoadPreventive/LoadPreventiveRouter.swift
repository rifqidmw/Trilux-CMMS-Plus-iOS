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
    
    func showBottomSheetAddPreventive(from navigation: UINavigationController, data: LoadPreventiveAsset) {
        let bottomSheet = AddPreventiveBottomSheet(nibName: String(describing: AddPreventiveBottomSheet.self), bundle: nil)
        //        bottomSheet.delegate = delegate
        bottomSheet.data = data
        bottomSheet.modalTransitionStyle = .coverVertical
        bottomSheet.modalPresentationStyle = .overCurrentContext
        navigation.present(bottomSheet, animated: true)
    }
    
}
