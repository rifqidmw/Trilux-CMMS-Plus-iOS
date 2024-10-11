//
//  MutationSubmissionRouter.swift
//  cmmsv2
//
//  Created by macbook  on 10/10/24.
//

import UIKit

class MutationSubmissionRouter: BaseRouter {
    
    func showView() -> MutationSubmissionView {
        let interactor = MutationSubmissionInteractor()
        let presenter = MutationSubmissionPresenter(interactor: interactor)
        let view = MutationSubmissionView(nibName: String(describing: MutationSubmissionView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}
