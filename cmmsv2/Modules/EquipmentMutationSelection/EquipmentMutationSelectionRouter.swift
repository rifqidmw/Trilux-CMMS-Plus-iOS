// 
//  EquipmentMutationSelectionRouter.swift
//  cmmsv2
//
//  Created by macbook  on 10/09/24.
//

import UIKit

class EquipmentMutationSelectionRouter {
    
    func showView() -> EquipmentMutationSelectionView {
        let interactor = EquipmentMutationSelectionInteractor()
        let presenter = EquipmentMutationSelectionPresenter(interactor: interactor)
        let view = EquipmentMutationSelectionView(nibName: String(describing: EquipmentMutationSelectionView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
    //Navigate to other xib-based router
    /*
    func navigateToOtherView(from navigation: UINavigationController, with data: Any) {
        let otherView = OtherViewRouter().showView(with: data)
        navigation.pushViewController(otherView, animated: true)
    }
    */
    
    //Navigate to other storyboard-based router
    /*
    func navigateToOtherView(from navigation: UINavigationController, with data: Any) {
        let otherView = OtherViewRouter().showView(with: data)
        navigation.pushViewController(otherView, animated: true)
    }
     */
    
}
