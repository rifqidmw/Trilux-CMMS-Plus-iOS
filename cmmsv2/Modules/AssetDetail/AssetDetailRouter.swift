//
//  AssetDetailRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 01/05/24.
//

import UIKit

class AssetDetailRouter: BaseRouter {
    
    func showView(type: AssetType, id: String?) -> AssetDetailView {
        let interactor = AssetDetailInteractor()
        let presenter = AssetDetailPresenter(interactor: interactor, router: self, type: type, id: id ?? "")
        let view = AssetDetailView(nibName: String(describing: AssetDetailView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}

extension AssetDetailRouter {
    
    func navigateToUpdateTechnicalData(from navigation: UINavigationController, _ id: String?) {
        let vc = EditTechnicalRouter().showView(id: id ?? "")
        navigation.pushViewController(vc, animated: true)
    }
    
    func navigateToDetailInformation(from navigation: UINavigationController, _ id: String?) {
        let vc = EquipmentMaintenanceRouter().showView(idAsset: id ?? "")
        navigation.pushViewController(vc, animated: true)
    }
    
}
