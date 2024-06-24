//
//  ComplaintDetailPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/05/24.
//

import UIKit

class ComplaintDetailPresenter: BasePresenter {
    
    private let interactor: ComplaintDetailInteractor
    private let router = ComplaintDetailRouter()
    let data: Complaint?
    
    @Published public var complaintData: ComplaintDetail?
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    init(interactor: ComplaintDetailInteractor, data: Complaint) {
        self.interactor = interactor
        self.data = data
    }
    
}

extension ComplaintDetailPresenter {
    
    func fetchInitialData() {
        guard let data, let id = data.id else { return }
        self.fetchDetailComplaintData(id: id)
    }
    
    func fetchDetailComplaintData(id: Int) {
        self.isLoading = true
        interactor.getComplaintDetail(id: id)
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
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
}
