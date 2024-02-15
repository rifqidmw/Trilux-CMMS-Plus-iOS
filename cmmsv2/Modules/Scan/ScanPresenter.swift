//
//  ScanPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/02/24.
//

import Foundation
import UIKit

class ScanPresenter: BasePresenter {
    
    private let interactor: ScanInteractor
    private let router = ScanRouter()
    
    @Published public var detailEquipmentData: ScanEquipment?
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    @Published public var isShowBottomSheet: Bool = false
    
    init(interactor: ScanInteractor) {
        self.interactor = interactor
    }
    
}

extension ScanPresenter {
    
    func didScanQRCode(_ qr: QRProperties?) {
        self.isLoading = true
        self.isShowBottomSheet = true
        interactor.getDetailEquipment(id: qr?.id ?? "")
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        self.isLoading = false
                        self.isShowBottomSheet = false
                    case .failure(let error):
                        AppLogger.log(error, logType: .kNetworkResponseError)
                        self.errorMessage = error.localizedDescription
                        self.isLoading = false
                        self.isError = true
                    }
                },
                receiveValue: { equipmentDetail in
                    DispatchQueue.main.async {
                        guard let equipment = equipmentDetail.data,
                              let data = equipment.equipment
                        else { return }
                        self.detailEquipmentData = data
                        self.isShowBottomSheet = false
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
}

extension ScanPresenter {
    
    func showBottomSheetDetailInformation(navigation: UINavigationController, data: ScanEquipment) {
        router.showBottomSheetDetailInformation(navigation: navigation, data: data)
    }
    
}
