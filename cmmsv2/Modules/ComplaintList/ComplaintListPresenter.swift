//
//  ComplaintListPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 07/03/24.
//

import UIKit

class ComplaintListPresenter: BasePresenter {
    
    private let interactor: ComplaintListInteractor
    private let router = ComplaintListRouter()
    
    init(interactor: ComplaintListInteractor) {
        self.interactor = interactor
    }
    
    var technicianList: SelectTechnicianEntity?
    @Published public var complaint: [Complaint] = []
    @Published public var advanceWorkSheet: CreateLanjutanEntity?
    @Published public var acceptCorrective: AcceptCorrectiveEntity?
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    var equipmentId: String = ""
    var status: String = "open,closed,progress"
    var dateFilter: String = ""
    var keyword: String = ""
    var page: Int = 1
    var limit: Int = 20
    var isCanLoad = true
    var isFetchingMore = false
    
}

extension ComplaintListPresenter {
    
    func fetchInitData() {
        self.fetchComplaintListData(equipmentId: self.equipmentId,
                                    status: self.status,
                                    limit: self.limit,
                                    page: self.page,
                                    dateFilter: self.dateFilter,
                                    keyword: self.keyword)
        self.fetchTechnicianList(job: "2")
    }
    
    func fetchComplaintListData(
        equipmentId: String, status: String, limit: Int, page: Int, dateFilter: String, keyword: String) {
            self.isLoading = true
            interactor.getComplaintList(
                page: page,
                limit: limit,
                equipmentId: equipmentId,
                status: status,
                dateFilter: dateFilter,
                keyword: keyword)
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
                receiveValue: { complains in
                    DispatchQueue.main.async {
                        guard let data = complains.data,
                              let complainsData = data.complains
                        else { return }
                        self.complaint.append(contentsOf: complainsData)
                    }
                }
            )
            .store(in: &anyCancellable)
        }
    
    func fetchNextPage() {
        guard !isFetchingMore && isCanLoad else { return }
        page += 1
        fetchComplaintListData(equipmentId: self.equipmentId,
                               status: self.status,
                               limit: self.limit,
                               page: self.page,
                               dateFilter: self.dateFilter,
                               keyword: self.keyword)
    }
    
    func fetchTechnicianList(job: String) {
        self.isLoading = true
        interactor.getTechnicianList(job: job)
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
                receiveValue: { technicians in
                    DispatchQueue.main.async {
                        self.technicianList = technicians
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func createAdvanceWorkSheet(engineerId: String?, complainId: String?, dueDate: String?, engineerPendamping: [String]?) {
        self.isLoading = true
        interactor.createLanjutan(engineerId: engineerId ?? "", complainId: complainId ?? "", dueDate: dueDate ?? "", engineerPendamping: engineerPendamping ?? [])
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
                receiveValue: { advanceWorkSheet in
                    DispatchQueue.main.async {
                        self.advanceWorkSheet = advanceWorkSheet
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func createAcceptCorrective(engineerId: String?, complainId: String?, dueDate: String?, engineerPendamping: [String]?) {
        self.isLoading = true
        interactor.createCorrective(engineerId: engineerId ?? "", complainId: complainId ?? "", dueDate: dueDate ?? "", engineerPendamping: engineerPendamping ?? [])
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
                receiveValue: { acceptCorrective in
                    DispatchQueue.main.async {
                        self.acceptCorrective = acceptCorrective
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
}

extension ComplaintListPresenter {
    
    func navigateToComplaintDetail(navigation: UINavigationController, data: Complaint) {
        router.navigateToComplaintDetail(navigation: navigation, data: data)
    }
    
    func showAddComplaintBottomSheet(from navigation: UINavigationController, data: Complaint, _ delegate: AddComplaintBottomSheetDelegate, type: CorrectiveTitleType) {
        let bottomSheet = AddComplaintBottomSheet(nibName: String(describing: AddComplaintBottomSheet.self), bundle: nil)
        bottomSheet.type = type
        bottomSheet.data = data
        bottomSheet.delegate = delegate
        router.showBottomSheet(nav: navigation, bottomSheetView: bottomSheet)
    }
    
    func showSelectTechnicianBottomSheet(from navigation: UINavigationController, type: SelectTechnicianBottomSheetType, _ delegate: SelectTechnicianBottomSheetDelegate) {
        let bottomSheet = SelectTechnicianBottomSheet(nibName: String(describing: SelectTechnicianBottomSheet.self), bundle: nil)
        let userList = self.technicianList?.data?.users?.compactMap { item in
            return TechnicianEntity(id: item.valId, name: item.txtName, isSelected: false)
        }
        bottomSheet.data = userList ?? []
        bottomSheet.type = type
        bottomSheet.delegate = delegate
        router.showBottomSheet(nav: navigation, bottomSheetView: bottomSheet)
    }
    
    func showDatePickerBottomSheet(from navigation: UINavigationController, delegate: DatePickerBottomSheetDelegate) {
        let bottomSheet = DatePickerBottomSheet(nibName: String(describing: DatePickerBottomSheet.self), bundle: nil)
        bottomSheet.delegate = delegate
        router.showBottomSheet(nav: navigation, bottomSheetView: bottomSheet)
    }
    
}
