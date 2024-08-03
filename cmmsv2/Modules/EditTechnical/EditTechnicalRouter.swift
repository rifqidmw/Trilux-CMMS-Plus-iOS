//
//  EditTechnicalRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 02/08/24.
//

import UIKit

class EditTechnicalRouter: BaseRouter {
    
    func showView(data: Equipment) -> EditTechnicalView {
        let interactor = EditTechnicalInteractor()
        let presenter = EditTechnicalPresenter(interactor: interactor, router: self, data: data)
        let view = EditTechnicalView(nibName: String(describing: EditTechnicalView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}
