//
//  DocumentRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/08/24.
//

import UIKit

class DocumentRouter: BaseRouter {
    
    func showView(file: String?, type: DocumentType) -> DocumentView {
        let interactor = DocumentInteractor()
        let presenter = DocumentPresenter(interactor: interactor, router: self, file: file ?? "", type: type)
        let view = DocumentView(nibName: String(describing: DocumentView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}
