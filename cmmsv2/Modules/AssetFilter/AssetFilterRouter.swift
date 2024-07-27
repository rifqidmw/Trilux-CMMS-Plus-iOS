//
//  AssetFilterRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 25/07/24.
//

import UIKit

class AssetFilterRouter: BaseRouter {
    
    func showView() -> AssetFilterView {
        let interactor = AssetFilterInteractor()
        let presenter = AssetFilterPresenter(interactor: interactor)
        let view = AssetFilterView(nibName: String(describing: AssetFilterView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}

extension AssetFilterRouter {
    
    func navigateToDetailAsset(navigation: UINavigationController, type: AssetType, data: Equipment) {
        let vc = AssetDetailRouter().showView(type: type, data: data)
        navigation.pushViewController(vc, animated: true)
    }
    
}

