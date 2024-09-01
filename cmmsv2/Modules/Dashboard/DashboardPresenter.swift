//
//  DashboardPresenter.swift
//  cmmsv2
//
//  Created by macbook  on 28/08/24.
//

import Foundation
import UIKit

class DashboardPresenter: BasePresenter {
    
    private let interactor: DashboardInteractor
    private let router = DashboardRouter()
    
    var technicianList: SelectTechnicianEntity?
    @Published public var performanceData: DashboardEngineerContent?
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    init(interactor: DashboardInteractor) {
        self.interactor = interactor
    }
    
}

extension DashboardPresenter {
    
    func fetchPerformanceDashboard(_ month: String?, _ year: String?, id: String?) {
        self.isLoading = true
        interactor.getDashboardPerformance(month: month ?? "", year: year ?? "", id: id ?? "")
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
                receiveValue: { performance in
                    DispatchQueue.main.async {
                        guard let detail = performance.data else { return }
                        self.performanceData = detail
                    }
                }
            )
            .store(in: &anyCancellable)
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
    
}

extension DashboardPresenter {
    
    func showSelectTechnicianBottomSheet(from navigation: UINavigationController, _ delegate: SelectTechnicianBottomSheetDelegate) {
        let bottomSheet = SelectTechnicianBottomSheet(nibName: String(describing: SelectTechnicianBottomSheet.self), bundle: nil)
        let userList = self.technicianList?.data?.users?.compactMap { item in
            return TechnicianEntity(id: item.valId, name: item.txtName, isSelected: false)
        }
        bottomSheet.data = userList ?? []
        bottomSheet.type = .selectOne
        bottomSheet.delegate = delegate
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
    func showDatePickerBottomSheet(from navigation: UINavigationController, delegate: DatePickerBottomSheetDelegate) {
        let bottomSheet = DatePickerBottomSheet(nibName: String(describing: DatePickerBottomSheet.self), bundle: nil)
        bottomSheet.delegate = delegate
        bottomSheet.selectedYear = Int(String.getCurrentDateString("yyyy")) ?? 2024
        bottomSheet.selectedMonth = Int(String.getCurrentDateString("MM")) ?? 12
        bottomSheet.type = .monthYear
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
}
