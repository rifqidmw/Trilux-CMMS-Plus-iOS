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

extension WorkSheetCorrectiveListRouter {
    
    func showBottomSheetCorrective(navigation: UINavigationController, data: WorkOrder, delegate: WorkSheetCorrectiveBottomSheetDelegate) {
        let bottomSheet = WorkSheetCorrectiveBottomSheet(nibName: String(describing: WorkSheetCorrectiveBottomSheet.self), bundle: nil)
        bottomSheet.modalPresentationStyle = .overCurrentContext
        bottomSheet.delegate = delegate
        bottomSheet.data = data
        navigation.present(bottomSheet, animated: true)
    }
    
    func navigateToDetailWorkSheetCorrective(navigation: UINavigationController, data: WorkOrder) {
        let vc = WorkSheetCorrectiveDetailRouter().showView(data: data)
        navigation.pushViewController(vc, animated: true)
    }
    
}
