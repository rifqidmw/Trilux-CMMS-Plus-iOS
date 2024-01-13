// 
//  HomeScreenPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 07/01/24.
//

import UIKit

class HomeScreenPresenter: BasePresenter {
    
    private let interactor: HomeScreenInteractor
    private let router = HomeScreenRouter()
    
    init(interactor: HomeScreenInteractor) {
        self.interactor = interactor
    }
    
}

extension HomeScreenPresenter {
    
    func showBottomSheetAllCategories(navigation: UINavigationController) {
        router.showAllCategoriesBottomSheet(navigation: navigation)
    }
    
    func showBottomSheetWorkSheet(navigation: UINavigationController) {
        router.showWorkSheetBottomSheet(navigation: navigation)
    }
    
    func showBottomSheetAsset(navigation: UINavigationController) {
        router.showAssetBottomSheet(navigation: navigation)
    }
    
    func showBottomSheetDetailInformation(navigation: UINavigationController) {
        router.showDetailInformationBottomSheet(navigation: navigation)
    }
    
    func navigateToUserProfile(navigation: UINavigationController) {
        router.goToUserProfile(navigation: navigation)
    }
    
}
