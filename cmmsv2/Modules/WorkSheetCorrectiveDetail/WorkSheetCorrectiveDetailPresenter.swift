//
//  WorkSheetCorrectiveDetailPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/05/24.
//

import Foundation
import UIKit

class WorkSheetCorrectiveDetailPresenter: BasePresenter {
    
    private let interactor: WorkSheetCorrectiveDetailInteractor
    private let router: WorkSheetCorrectiveDetailRouter
    let data: WorkOrder?
    
    @Published public var complaintData: WorkSheetCorrectiveComplaint?
    var complaintEquipment: CorrectiveEquipment?
    var trackData: [TrackComplaintData] = []
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    init(interactor: WorkSheetCorrectiveDetailInteractor, router: WorkSheetCorrectiveDetailRouter, data: WorkOrder) {
        self.interactor = interactor
        self.router = router
        self.data = data
    }
    
}

extension WorkSheetCorrectiveDetailPresenter {
    
    func fetchInitialData() {
        guard let data,
              let complain = data.complain,
              let id = complain.id,
              let asset = complain.equipment,
              let idAsset = asset.id
        else { return }
        self.fetchDetailCorrective(id: id)
        self.fetchComplaintTracking(id: String(idAsset))
    }
    
    func fetchDetailCorrective(id: Int) {
        self.isLoading = true
        interactor.getDetailCorrective(id: id)
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
                receiveValue: { detailComplaint in
                    DispatchQueue.main.async {
                        guard let data = detailComplaint.data, let complaintDetail = data.complain else { return }
                        self.complaintData = complaintDetail
                        self.complaintEquipment = complaintDetail.equipment
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func fetchComplaintTracking(id: String) {
        self.isLoading = true
        interactor.getComplaintTracking(id: id)
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
                receiveValue: { tracking in
                    DispatchQueue.main.async {
                        guard let data = tracking.data else { return }
                        self.trackData = data
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
}

extension WorkSheetCorrectiveDetailPresenter {
    
    func showTrackingBottomSheet(from navigation: UINavigationController) {
        let bottomSheet = TrackProgressBottomSheet(nibName: String(describing: TrackProgressBottomSheet.self), bundle: nil)
        bottomSheet.data = self.trackData
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
}
