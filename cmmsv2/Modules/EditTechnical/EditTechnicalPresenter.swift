//
//  EditTechnicalPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 02/08/24.
//

import Foundation
import UIKit

class EditTechnicalPresenter: BasePresenter {
    
    private let interactor: EditTechnicalInteractor
    private let router: EditTechnicalRouter
    let id: String?
    
    @Published public var technicalData: TechnicalEntity?
    @Published public var saveTechnicalData: SaveTechnicalEntity?
    var reference: TechnicalReference?
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    init(interactor: EditTechnicalInteractor, router: EditTechnicalRouter, id: String) {
        self.interactor = interactor
        self.router = router
        self.id = id
    }
    
}

extension EditTechnicalPresenter {
    
    func fetchInitData() {
        guard let id else { return }
        fetchLoadTechnicalData(id: id)
    }
    
    func fetchLoadTechnicalData(id: String) {
        self.isLoading = true
        interactor.getLoadTechnicalData(id: id)
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
                receiveValue: { technicalData in
                    DispatchQueue.main.async {
                        self.technicalData = technicalData
                        self.reference = technicalData.reff
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func saveTechnicalData(data: EditTechnicalRequestEntity) {
        self.isLoading = true
        interactor.saveTechnicalData(data: data)
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
                receiveValue: { technical in
                    DispatchQueue.main.async {
                        self.saveTechnicalData = technical
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
}

extension EditTechnicalPresenter {
    
    func showSelectTechnologyBottomSheet(from navigation: UINavigationController, delegate: SelectTechnicalDataBottomSheetDelegate) {
        let bottomSheet = SelectTechnicalDataBottomSheet(nibName: String(describing: SelectTechnicalDataBottomSheet.self), bundle: nil)
        bottomSheet.data = self.reference?.tech ?? []
        bottomSheet.delegate = delegate
        bottomSheet.type = .technology
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
    func showSelectPriorityBottomSheet(from navigation: UINavigationController, delegate: SelectTechnicalDataBottomSheetDelegate) {
        let bottomSheet = SelectTechnicalDataBottomSheet(nibName: String(describing: SelectTechnicalDataBottomSheet.self), bundle: nil)
        bottomSheet.data = self.reference?.priority ?? []
        bottomSheet.delegate = delegate
        bottomSheet.type = .priority
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
    func showSelectFrequencyBottomSheet(from navigation: UINavigationController, delegate: SelectTechnicalDataBottomSheetDelegate) {
        let bottomSheet = SelectTechnicalDataBottomSheet(nibName: String(describing: SelectTechnicalDataBottomSheet.self), bundle: nil)
        bottomSheet.data = self.reference?.frekuensi ?? []
        bottomSheet.delegate = delegate
        bottomSheet.type = .frequency
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
    func showSelectMelopsiBottomSheet(from navigation: UINavigationController, delegate: SelectTechnicalDataBottomSheetDelegate) {
        let bottomSheet = SelectTechnicalDataBottomSheet(nibName: String(describing: SelectTechnicalDataBottomSheet.self), bundle: nil)
        bottomSheet.data = self.reference?.melopsi ?? []
        bottomSheet.delegate = delegate
        bottomSheet.type = .melopsi
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
}
