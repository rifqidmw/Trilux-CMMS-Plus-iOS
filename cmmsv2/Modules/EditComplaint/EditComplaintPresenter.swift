//
//  EditComplaintPresenter.swift
//  cmmsv2
//
//  Created by macbook  on 22/09/24.
//

import Foundation

class EditComplaintPresenter: BasePresenter {
    
    private let interactor: EditComplaintInteractor
    private let router: EditComplaintRouter
    var id: String?
    var valType: String?
    
    @Published public var complaintData: ComplaintDetail?
    @Published public var updateComplaintData: UpdateComplaintResponseEntity?
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    init(interactor: EditComplaintInteractor, router: EditComplaintRouter, id: String, valType: String) {
        self.interactor = interactor
        self.router = router
        self.id = id
        self.valType = valType
    }
    
}

extension EditComplaintPresenter {
    
    func fetchInitialData() {
        guard let id else { return }
        self.fetchDetailComplaintData(id: Int(id) ?? 0)
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
    
    func updateComplaintData(_ request: UpdateComplaintRequestEntity?, id: String?) {
        self.isLoading = true
        guard let request, let id else { return }
        interactor.updateComplaint(request, id: id)
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
                receiveValue: { updateData in
                    DispatchQueue.main.async {
                        self.updateComplaintData = updateData
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
}
