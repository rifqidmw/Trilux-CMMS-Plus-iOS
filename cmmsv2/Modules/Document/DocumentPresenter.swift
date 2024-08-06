//
//  DocumentPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/08/24.
//

import Foundation

class DocumentPresenter: BasePresenter {
    
    private let interactor: DocumentInteractor
    private let router: DocumentRouter
    var type: DocumentType?
    var file: String?
    
    init(interactor: DocumentInteractor, router: DocumentRouter, file: String, type: DocumentType) {
        self.interactor = interactor
        self.router = router
        self.file = file
        self.type = type
    }
    
}
