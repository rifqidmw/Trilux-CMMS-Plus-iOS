// 
//  RatingListRouter.swift
//  cmmsv2
//
//  Created by macbook  on 01/10/24.
//

import UIKit

class RatingListRouter: BaseRouter {
    
    func showView() -> RatingListView {
        let interactor = RatingListInteractor()
        let presenter = RatingListPresenter(interactor: interactor)
        let view = RatingListView(nibName: String(describing: RatingListView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}
