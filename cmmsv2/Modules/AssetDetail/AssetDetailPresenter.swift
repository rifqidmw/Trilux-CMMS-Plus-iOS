//
//  AssetDetailPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 01/05/24.
//

import Foundation

class AssetDetailPresenter: BasePresenter {
    
    private let interactor: AssetDetailInteractor
    private let router: AssetDetailRouter
    private let type: AssetType
    private let data: Equipment?
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    init(interactor: AssetDetailInteractor, router: AssetDetailRouter, type: AssetType, data: Equipment) {
        self.interactor = interactor
        self.router = router
        self.type = type
        self.data = data
    }
    
}
