// 
//  MedicAssetListRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/02/24.
//

import UIKit

class MedicAssetListRouter: BaseRouter {
    
    func showView() -> MedicAssetListView {
        let interactor = MedicAssetListInteractor()
        let presenter = MedicAssetListPresenter(interactor: interactor)
        let view = MedicAssetListView(nibName: String(describing: MedicAssetListView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}
