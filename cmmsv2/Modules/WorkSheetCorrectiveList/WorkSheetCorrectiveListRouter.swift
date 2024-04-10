//
//  WorkSheetCorrectiveRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/03/24.
//

import UIKit

class WorkSheetCorrectiveListRouter: BaseInteractor {
    
    func showView() -> WorkSheetCorrectiveListView {
        let interactor = WorkSheetCorrectiveListInteractor()
        let presenter = WorkSheetCorrectiveListPresenter(interactor: interactor)
        let view = WorkSheetCorrectiveListView(nibName: String(describing: WorkSheetCorrectiveListView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}
