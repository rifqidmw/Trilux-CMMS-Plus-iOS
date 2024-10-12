//
//  EquipmentManagementRouter.swift
//  cmmsv2
//
//  Created by macbook  on 10/09/24.
//

import UIKit

class EquipmentManagementListRouter: BaseRouter {
    
    func showView(type: EquipmentManagementType) -> EquipmentManagementListView {
        let interactor = EquipmentManagementListInteractor()
        let presenter = EquipmentManagementListPresenter(interactor: interactor, router: self, type: type)
        let view = EquipmentManagementListView(nibName: String(describing: EquipmentManagementListView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}

extension EquipmentManagementListRouter {
    
    func navigateToAssetMedicList(navigation: UINavigationController) {
        let vc = AssetListRouter().showView(type: .medic)
        navigation.dismiss(animated: true)
        navigation.pushViewController(vc, animated: true)
    }
    
    func navigateToEquipmentManagementDetail(from navigation: UINavigationController, _ id: String?, type: EquipmentManagementType) {
        let vc = EquipmentManagementDetailRouter().showView(type: type, id ?? "")
        navigation.pushViewController(vc, animated: true)
    }
    
    func navigateToMutationSubmission(from navigation: UINavigationController) {
        let vc = MutationSubmissionRouter().showView()
        navigation.pushViewController(vc, animated: true)
    }
    
}
