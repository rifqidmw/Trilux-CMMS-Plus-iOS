//
//  RoomRequirementListRouter.swift
//  cmmsv2
//
//  Created by macbook  on 03/10/24.
//

import UIKit

class RoomRequirementListRouter: BaseRouter {
    
    func showView(_ type: AssetType) -> RoomRequirementListView {
        let interactor = RoomRequirementListInteractor()
        let presenter = RoomRequirementListPresenter(interactor: interactor, router: self, type: type)
        let view = RoomRequirementListView(nibName: String(describing: RoomRequirementListView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}

extension RoomRequirementListRouter {
    
    func navigateToEquipmentProcurement(from navigation: UINavigationController, _ data: RoomRequirementListData? = nil) {
        let vc = EquipmentProcurementRouter().showView(data)
        navigation.pushViewController(vc, animated: true)
    }
    
}
