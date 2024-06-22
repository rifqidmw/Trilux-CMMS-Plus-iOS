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
    
    func navigateToComplaintDetail(navigation: UINavigationController, data: Complaint) {
        let vc = ComplaintDetailRouter().showView(data: data)
        navigation.pushViewController(vc, animated: true)
    }
    
    func showBottomSheet(nav: UINavigationController, bottomSheetView: UIViewController) {
        bottomSheetView.loadViewIfNeeded()
        bottomSheetView.modalPresentationStyle = .overCurrentContext
        UIApplication.topViewController()?.present(bottomSheetView, animated: true, completion: nil)
    }
    
}
