//
//  FullScreenPicturePresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 21/01/24.
//

import UIKit

class FullScreenPicturePresenter: BasePresenter {
    
    private let interactor: FullScreenPictureInteractor
    private let router = FullScreenPictureRouter()
    let image: String?
    
    init(interactor: FullScreenPictureInteractor, image: String) {
        self.interactor = interactor
        self.image = image
    }
    
}
