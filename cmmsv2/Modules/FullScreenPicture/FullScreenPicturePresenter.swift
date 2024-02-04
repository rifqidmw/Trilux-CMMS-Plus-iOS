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
    
    init(interactor: FullScreenPictureInteractor) {
        self.interactor = interactor
    }
    
}
