//
//  WorkSheetApprovalDetailRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/08/24.
//

import UIKit

class WorkSheetApprovalDetailRouter: BaseRouter {
    
    func showView(id: String?) -> WorkSheetApprovalDetailView {
        let interactor = WorkSheetApprovalDetailInteractor()
        let presenter = WorkSheetApprovalDetailPresenter(interactor: interactor, router: self, id: id ?? "")
        let view = WorkSheetApprovalDetailView(nibName: String(describing: WorkSheetApprovalDetailView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}
