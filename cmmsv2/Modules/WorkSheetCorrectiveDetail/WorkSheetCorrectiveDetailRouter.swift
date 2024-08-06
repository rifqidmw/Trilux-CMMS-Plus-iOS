//
//  WorkSheetCorrectiveDetailRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/05/24.
//

import UIKit

class WorkSheetCorrectiveDetailRouter: BaseRouter {
    
    func showView(idAset: String?, idComplaint: String?) -> WorkSheetCorrectiveDetailView {
        let interactor = WorkSheetCorrectiveDetailInteractor()
        let presenter = WorkSheetCorrectiveDetailPresenter(interactor: interactor, router: self, idAsset: idAset ?? "", idComplaint: idComplaint ?? "")
        let view = WorkSheetCorrectiveDetailView(nibName: String(describing: WorkSheetCorrectiveDetailView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}
