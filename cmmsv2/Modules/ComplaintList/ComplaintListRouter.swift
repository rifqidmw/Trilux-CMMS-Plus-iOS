//
//  ComplaintListRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 07/03/24.
//

import UIKit

class ComplaintListRouter: BaseRouter {
    
    func showView(_ type: ComplaintType) -> ComplaintListView {
        let interactor = ComplaintListInteractor()
        let presenter = ComplaintListPresenter(interactor: interactor, router: self, type: type)
        let view = ComplaintListView(nibName: String(describing: ComplaintListView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}

extension ComplaintListRouter {
    
    func navigateToEditComplaint(from navigation: UINavigationController, _ id: String?, valType: String?) {
        let vc = EditComplaintRouter().showView(id ?? "", valType: valType ?? "")
        navigation.pushViewController(vc, animated: true)
    }
    
}
