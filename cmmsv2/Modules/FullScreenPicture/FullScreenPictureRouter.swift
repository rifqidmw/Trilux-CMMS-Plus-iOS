//
//  FullScreenPictureRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 21/01/24.
//

import UIKit

class FullScreenPictureRouter: BaseRouter {
    
    func showView(image: String) -> FullScreenPictureView {
        let interactor = FullScreenPictureInteractor()
        let presenter = FullScreenPicturePresenter(interactor: interactor, image: image)
        let view = FullScreenPictureView(nibName: String(describing: FullScreenPictureView.self), bundle: nil)
        view.presenter = presenter
        view.image = image
        return view
    }
    
}
