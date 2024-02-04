// 
//  WorkSheetOnsitePreventiveListRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 22/01/24.
//

import UIKit

class WorkSheetOnsitePreventiveListRouter: BaseRouter {
    
    func showView() -> WorkSheetOnsitePreventiveListView {
        let interactor = WorkSheetOnsitePreventiveListInteractor()
        let presenter = WorkSheetOnsitePreventiveListPresenter(interactor: interactor)
        let view = WorkSheetOnsitePreventiveListView(nibName: String(describing: WorkSheetOnsitePreventiveListView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}

extension WorkSheetOnsitePreventiveListRouter {
    
    func showActionBottomSheet(navigation: UINavigationController, type: WorkSheetActionType, delegate: WorkSheetOnsitePreventiveDelegate) {
        let bottomSheet = SelectActionBottomSheet(nibName: String(describing: SelectActionBottomSheet.self), bundle: nil)
        bottomSheet.delegate = delegate
        bottomSheet.type = type
        bottomSheet.modalPresentationStyle = .overCurrentContext
        navigation.present(bottomSheet, animated: true)
    }
    
}
