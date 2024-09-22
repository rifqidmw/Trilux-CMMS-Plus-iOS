//
//  EditComplaintRouter.swift
//  cmmsv2
//
//  Created by macbook  on 22/09/24.
//

import UIKit

class EditComplaintRouter: BaseRouter {
    
    func showView(_ id: String?, valType: String?) -> EditComplaintView {
        let interactor = EditComplaintInteractor()
        let presenter = EditComplaintPresenter(interactor: interactor, router: self, id: id ?? "", valType: valType ?? "")
        let view = EditComplaintView(nibName: String(describing: EditComplaintView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}
