//
//  WorkSheetCorrectiveRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/03/24.
//

import UIKit

class WorkSheetCorrectiveRouter: BaseInteractor {
    
    func showView() -> WorkSheetCorrectiveView {
        let interactor = WorkSheetCorrectiveInteractor()
        let presenter = WorkSheetCorrectivePresenter(interactor: interactor)
        let view = WorkSheetCorrectiveView(nibName: String(describing: WorkSheetCorrectiveView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}
