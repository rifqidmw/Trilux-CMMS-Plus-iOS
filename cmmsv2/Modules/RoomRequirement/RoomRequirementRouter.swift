//
//  RoomRequirementRouter.swift
//  cmmsv2
//
//  Created by macbook  on 10/09/24.
//

import UIKit

class RoomRequirementRouter: BaseRouter {
    
    func showView() -> RoomRequirementView {
        let interactor = RoomRequirementInteractor()
        let presenter = RoomRequirementPresenter(interactor: interactor)
        let view = RoomRequirementView(nibName: String(describing: RoomRequirementView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
}
