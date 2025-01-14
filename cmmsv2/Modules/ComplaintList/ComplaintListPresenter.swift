//
//  ComplaintListPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 07/03/24.
//

import UIKit

class ComplaintListPresenter: BasePresenter {
    
    private let interactor: ComplaintListInteractor
    private let router: ComplaintListRouter
    var type: ComplaintType
    
    init(interactor: ComplaintListInteractor, router: ComplaintListRouter, type: ComplaintType) {
        self.interactor = interactor
        self.router = router
        self.type = type
    }
    
    var technicianList: SelectTechnicianEntity?
    @Published public var complaint: [Complaint] = []
    @Published public var advanceWorkSheet: CreateLanjutanEntity?
    @Published public var acceptCorrective: AcceptCorrectiveEntity?
    @Published public var deletedLkData: DeleteComplaintEntity?
    @Published public var deletedComplaintData: DeleteComplaintResponseEntity?
    var filterStatusData: [StatusFilterEntity] = [
        StatusFilterEntity(id: "0", status: .open),
        StatusFilterEntity(id: "1", status: .progress),
        StatusFilterEntity(id: "2", status: .closed),
    ]
    
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
    
    func fetchInitData(keyword: String? = nil, status: String? = nil) {
        if let status = status {
            self.status = status
        }
        if let keyword = keyword {
            self.keyword = keyword
        }
        
        self.page = 1
        self.complaint.removeAll()
        self.fetchComplaintListData(
            equipmentId: self.equipmentId,
            status: self.status,
            limit: self.limit,
            page: self.page,
            dateFilter: self.dateFilter,
            keyword: self.keyword)
        self.fetchTechnicianList(job: "2")
    }
    
    func fetchComplaintListData(
        equipmentId: String,
        status: String,
        limit: Int,
        page: Int,
        dateFilter: String,
        keyword: String) {
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
                        
                        let filteredData = complainsData.filter { newItem in
                            !self.complaint.contains(where: { $0.id == newItem.id })
                        }
                        
                        self.complaint.append(contentsOf: filteredData)
                    }
                }
            )
            .store(in: &anyCancellable)
        }
    
    func fetchNextPage() {
        guard !isFetchingMore && isCanLoad else { return }
        page += 1
        fetchComplaintListData(
            equipmentId: self.equipmentId,
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
    
    func deleteWorkSheet(idLk: String?) {
        self.isLoading = true
        interactor.deleteLk(idLk: idLk ?? "")
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
                receiveValue: { deletedLk in
                    DispatchQueue.main.async {
                        self.deletedLkData = deletedLk
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func deleteComplaint(id: String?) {
        self.isLoading = true
        interactor.deleteComplaint(id ?? "")
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
                receiveValue: { deletedComplaint in
                    DispatchQueue.main.async {
                        self.deletedComplaintData = deletedComplaint
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
}

extension ComplaintListPresenter {
    
    func showAddComplaintBottomSheet(from navigation: UINavigationController, data: Complaint, _ delegate: AddComplaintBottomSheetDelegate, type: CorrectiveTitleType) {
        let bottomSheet = AddComplaintBottomSheet(nibName: String(describing: AddComplaintBottomSheet.self), bundle: nil)
        bottomSheet.type = type
        bottomSheet.data = data
        bottomSheet.delegate = delegate
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
    func showSelectTechnicianBottomSheet(from navigation: UINavigationController, type: SelectTechnicianBottomSheetType, _ delegate: SelectTechnicianBottomSheetDelegate) {
        let bottomSheet = SelectTechnicianBottomSheet(nibName: String(describing: SelectTechnicianBottomSheet.self), bundle: nil)
        let userList = self.technicianList?.data?.users?.compactMap { item in
            return TechnicianEntity(id: item.valId, name: item.txtName, isSelected: false)
        }
        bottomSheet.data = userList ?? []
        bottomSheet.type = type
        bottomSheet.delegate = delegate
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
    func showDatePickerBottomSheet(from navigation: UINavigationController, delegate: DatePickerBottomSheetDelegate) {
        let bottomSheet = DatePickerBottomSheet(nibName: String(describing: DatePickerBottomSheet.self), bundle: nil)
        bottomSheet.delegate = delegate
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
    func showFilterStatusBottomSheet(from navigation: UINavigationController, delegate: FilterStatusBottomSheetDelegate) {
        let bottomSheet = FilterStatusBottomSheet(nibName: String(describing: FilterStatusBottomSheet.self), bundle: nil)
        bottomSheet.data = self.filterStatusData
        bottomSheet.delegate = delegate
        bottomSheet.type = .multiple
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
    func showComplaintActionBottomSheet(from navigation: UINavigationController, delegate: SelectComplaintActionBottomSheetDelegate, _ id: String?, type: SelectComplaintType, valType: String? = nil) {
        let bottomSheet = SelectComplaintActionBottomSheet(nibName: String(describing: SelectComplaintActionBottomSheet.self), bundle: nil)
        bottomSheet.delegate = delegate
        bottomSheet.type = type
        bottomSheet.id = id ?? ""
        bottomSheet.valType = valType ?? ""
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
    func showDeleteConfirmationPopUp(from navigation: UINavigationController, delegate: DeleteComplaintConfirmBottomSheetDelegate, _ id: String?) {
        let bottomSheet = DeleteComplaintConfirmBottomSheet(nibName: String(describing: DeleteComplaintConfirmBottomSheet.self), bundle: nil)
        bottomSheet.delegate = delegate
        bottomSheet.id = id ?? ""
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
    func navigateToEditComplaint(from navigation: UINavigationController, _ id: String?, valType: String?) {
        router.navigateToEditComplaint(from: navigation, id ?? "", valType: valType ?? "")
    }
    
}
