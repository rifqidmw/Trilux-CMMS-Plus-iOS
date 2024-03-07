//
//  AssetListRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/02/24.
//

import UIKit

class AssetListRouter: BaseRouter {
    
    func showView(assetType: AssetType) -> AssetListView {
        let interactor = AssetListInteractor()
        let presenter = AssetListPresenter(interactor: interactor, router: self, assetType: assetType)
        let view = AssetListView(nibName: String(describing: AssetListView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}
