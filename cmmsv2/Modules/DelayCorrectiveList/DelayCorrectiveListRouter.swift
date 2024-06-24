//
//  CorrectiveHoldListRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 14/03/24.
//

import UIKit

class DelayCorrectiveListRouter: BaseRouter {
    
    func showView() -> DelayCorrectiveListView {
        let interactor = DelayCorrectiveListInteractor()
        let presenter = DelayCorrectiveListPresenter(interactor: interactor)
        let view = DelayCorrectiveListView(nibName: String(describing: DelayCorrectiveListView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}

extension DelayCorrectiveListRouter {
    
    func navigateToDetailComplaint(from navigation: UINavigationController, data: Complaint) {
        let vc = DelayCorrectiveDetailRouter().showView(data: data)
        navigation.pushViewController(vc, animated: true)
    }
    
}
