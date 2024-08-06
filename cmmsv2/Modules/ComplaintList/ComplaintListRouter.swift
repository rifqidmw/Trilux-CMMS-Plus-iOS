//
//  ComplaintListRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 07/03/24.
//

import UIKit

class ComplaintListRouter: BaseRouter {
    
    func showView() -> ComplaintListView {
        let interactor = ComplaintListInteractor()
        let presenter = ComplaintListPresenter(interactor: interactor)
        let view = ComplaintListView(nibName: String(describing: ComplaintListView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}

extension ComplaintListRouter {
    
    func navigateToComplaintDetail(navigation: UINavigationController, id: String?) {
        let vc = ComplaintDetailRouter().showView(id: id ?? "")
        navigation.pushViewController(vc, animated: true)
    }
    
}
