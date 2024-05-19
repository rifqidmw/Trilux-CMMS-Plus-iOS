//
//  HistoryListRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/03/24.
//

import UIKit

class HistoryListRouter: BaseRouter {
    
    func showView() -> HistoryListView {
        let interactor = HistoryListInteractor()
        let presenter = HistoryListPresenter(interactor: interactor)
        let view = HistoryListView(nibName: String(describing: HistoryListView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}

extension HistoryListRouter {
    
    func navigateToHistoryDetail(navigation: UINavigationController, data: WorkSheetListEntity) {
        let vc = HistoryDetailRouter().showView(data: data)
        navigation.pushViewController(vc, animated: true)
    }
    
}
