// 
//  HomeScreenRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 07/01/24.
//

import UIKit

class HomeScreenRouter: BaseRouter {
    
    func showView() -> HomeScreenView {
        let interactor = HomeScreenInteractor()
        let presenter = HomeScreenPresenter(interactor: interactor)
        let view = HomeScreenView(nibName: String(describing: HomeScreenView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}

extension HomeScreenRouter {
    
    func showAllCategoriesBottomSheet(navigation: UINavigationController) {
        let bottomSheet = AllCategoriesBottomSheet(nibName: String(describing: AllCategoriesBottomSheet.self), bundle: nil)
        bottomSheet.modalPresentationStyle = .overCurrentContext
        navigation.present(bottomSheet, animated: true)
    }
    
    func showWorkSheetBottomSheet(navigation: UINavigationController) {
        let bottomSheet = MedicAssetBottomSheet(nibName: String(describing: MedicAssetBottomSheet.self), bundle: nil)
        bottomSheet.type = .worksheet
        bottomSheet.modalPresentationStyle = .overCurrentContext
        navigation.present(bottomSheet, animated: true)
    }
    
    func showAssetBottomSheet(navigation: UINavigationController) {
        let bottomSheet = MedicAssetBottomSheet(nibName: String(describing: MedicAssetBottomSheet.self), bundle: nil)
        bottomSheet.type = .asset
        bottomSheet.modalPresentationStyle = .overCurrentContext
        navigation.present(bottomSheet, animated: true)
    }
    
    func showDetailInformationBottomSheet(navigation: UINavigationController) {
        let bottomSheet = InformationDetailBottomSheet(nibName: String(describing: InformationDetailBottomSheet.self), bundle: nil)
        bottomSheet.modalPresentationStyle = .overCurrentContext
        navigation.present(bottomSheet, animated: true)
    }
    
}
