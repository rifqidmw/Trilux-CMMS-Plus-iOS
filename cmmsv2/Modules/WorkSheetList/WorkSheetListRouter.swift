// 
//  WorkSheetListRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 14/01/24.
//

import UIKit

class WorkSheetListRouter: BaseRouter {
    
    func showView() -> WorkSheetListView {
        let interactor = WorkSheetListInteractor()
        let presenter = WorkSheetListPresenter(interactor: interactor)
        let view = WorkSheetListView(nibName: String(describing: WorkSheetListView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}

extension WorkSheetListRouter {
    
    func backToHomeScreen() {
        let vc = HomeScreenRouter().showView()
        let rootController = UINavigationController(rootViewController: vc)
        UIApplication.shared.windows.first?.rootViewController = rootController
    }
    
}
