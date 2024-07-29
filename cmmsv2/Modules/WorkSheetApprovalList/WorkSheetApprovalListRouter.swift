// 
//  WorkSheetApprovalListRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 30/07/24.
//

import UIKit

class WorkSheetApprovalListRouter: BaseRouter {
    
    func showView() -> WorkSheetApprovalListView {
        let interactor = WorkSheetApprovalListInteractor()
        let presenter = WorkSheetApprovalListPresenter(interactor: interactor)
        let view = WorkSheetApprovalListView(nibName: String(describing: WorkSheetApprovalListView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}
