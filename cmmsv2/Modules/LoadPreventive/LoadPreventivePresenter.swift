//
//  LoadPreventivePresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 29/05/24.
//

import Foundation
import UIKit

class LoadPreventivePresenter: BasePresenter {
    
    private let interactor: LoadPreventiveInteractor
    private let router: LoadPreventiveRouter
    let data: WorkSheetListEntity?
    
    @Published public var loadPreventiveData: LoadPreventiveData?
    @Published public var createPreventiveData: CreatePreventiveEntity?
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    init(interactor: LoadPreventiveInteractor, router: LoadPreventiveRouter, data: WorkSheetListEntity) {
        self.interactor = interactor
        self.router = router
        self.data = data
    }
    
}

extension LoadPreventivePresenter {
    
    func fetchInitData() {
        guard let data = self.data, let idAsset = data.idAsset else { return }
        self.fetchPreventiveLoadList(id: idAsset)
    }
    
    func fetchPreventiveLoadList(id: String?) {
        self.isLoading = true
        interactor.getPreventiveLoadList(id: id ?? "")
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        self.isLoading = false
                    case .failure(let error):
                        AppLogger.log(error, logType: .kNetworkResponseError)
                        self.errorMessage = error.localizedDescription
                        self.isLoading = false
                        self.isError = true
                    }
                },
                receiveValue: { preventive in
                    DispatchQueue.main.async {
                        guard let preventiveData = preventive.data else { return }
                        self.loadPreventiveData = preventiveData
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func createPreventive(data: CreatePreventiveRequest) {
        self.isLoading = true
        interactor.createPreventive(data: data)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        self.isLoading = false
                    case .failure(let error):
                        AppLogger.log(error, logType: .kNetworkResponseError)
                        self.errorMessage = error.localizedDescription
                        self.isLoading = false
                        self.isError = true
                    }
                },
                receiveValue: { preventive in
                    DispatchQueue.main.async {
                        self.createPreventiveData = preventive
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
}

extension LoadPreventivePresenter {
    
    func showBottomSheetAddPreventive(from navigation: UINavigationController, _ delegate: AddPreventiveBottomSheetDelegate) {
        guard let data = self.loadPreventiveData,
              let asset = data.asset
        else { return }
        let bottomSheet = AddPreventiveBottomSheet(nibName: String(describing: AddPreventiveBottomSheet.self), bundle: nil)
        bottomSheet.delegate = delegate
        bottomSheet.data = asset
        router.showBottomSheet(nav: navigation, bottomSheetView: bottomSheet)
    }
    
    func showDatePickerBottomSheet(from navigation: UINavigationController, delegate: DatePickerBottomSheetDelegate, type: DatePickerBottomSheetType) {
        let bottomSheet = DatePickerBottomSheet(nibName: String(describing: DatePickerBottomSheet.self), bundle: nil)
        bottomSheet.delegate = delegate
        bottomSheet.type = type
        router.showBottomSheet(nav: navigation, bottomSheetView: bottomSheet)
    }
    
}
