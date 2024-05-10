//
//  ComplaintDetailRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/05/24.
//

import UIKit

class ComplaintDetailRouter: BaseRouter {
    
    func showView(data: ComplaintListEntity) -> ComplaintDetailView {
        let interactor = ComplaintDetailInteractor()
        let presenter = ComplaintDetailPresenter(interactor: interactor, data: data)
        let view = ComplaintDetailView(nibName: String(describing: ComplaintDetailView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}

extension ComplaintDetailRouter {
    
    func navigateToDetailPicture(navigation: UINavigationController, image: String) {
        let vc = FullScreenPictureRouter().showView(image: image)
        navigation.pushViewController(vc, animated: true)
    }
    
}
