//
//  RoomRequirementListPresenter.swift
//  cmmsv2
//
//  Created by macbook  on 03/10/24.
//

import Foundation
import UIKit

class RoomRequirementListPresenter: BasePresenter {
    
    private let interactor: RoomRequirementListInteractor
    private let router: RoomRequirementListRouter
    let type: AssetType
    
    @Published public var roomRequirementList: [RoomRequirementListData] = []
    
    var sortingData: [SortingEntity] = [
        SortingEntity(id: "0", sortType: .latest),
        SortingEntity(id: "1", sortType: .longest)
    ]
    var conditionFilterData: [AssetConditionEntity] = [
        AssetConditionEntity(id: "0", assetCondition: .all),
        AssetConditionEntity(id: "1", assetCondition: .forwarded),
        AssetConditionEntity(id: "2", assetCondition: .pending),
        AssetConditionEntity(id: "3", assetCondition: .rejected),
    ]
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    var page: Int = 1
    var group: String = ""
    var condition: String = ""
    var keyword: String = ""
    var year: String = String.getCurrentDateString("yyyy")
    var sort: String = "terbaru"
    var isCanLoad = true
    var isFetchingMore = false
    
    init(interactor: RoomRequirementListInteractor, router: RoomRequirementListRouter, type: AssetType) {
        self.interactor = interactor
        self.router = router
        self.type = type
    }
    
}

extension RoomRequirementListPresenter {
    
    func fetchInitData(
        group: String? = nil,
        condition: String? = nil,
        keyword: String? = nil,
        year: String? = nil,
        sort: String? = nil
    ) {
        if let group {
            self.group = group
        }
        
        if let condition {
            self.condition = condition
        }
        
        if let keyword {
            self.keyword = keyword
        }
        
        if let year {
            self.year = year
        }
        
        if let sort {
            self.sort = sort
        }
        
        self.page = 1
        self.roomRequirementList.removeAll()
        fetchRoomRequirementList(
            page: self.page,
            type: self.group,
            condition: self.condition,
            keyword: self.keyword,
            year: self.year,
            sort: self.sort)
    }
    
    func fetchRoomRequirementList(
        page: Int,
        type: String,
        condition: String,
        keyword: String,
        year: String,
        sort: String
    ) {
        self.isLoading = true
        interactor.getRoomRequirementList(
            condition: condition,
            keyword: keyword,
            year: year,
            type: type,
            page: page,
            sort: sort)
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
            receiveValue: { usulanData in
                DispatchQueue.main.async {
                    guard let data = usulanData.data else { return }
                    self.roomRequirementList.append(contentsOf: data)
                }
            }
        )
        .store(in: &anyCancellable)
    }
    
    func fetchNextPage() {
        guard !isFetchingMore && isCanLoad else { return }
        page += 1
        fetchRoomRequirementList(
            page: self.page,
            type: self.group,
            condition: self.condition,
            keyword: self.keyword,
            year: self.year,
            sort: self.sort)
    }
    
}

extension RoomRequirementListPresenter {
    
    func navigateToEquipmentProcurement(from navigation: UINavigationController, _ data: RoomRequirementListData? = nil) {
        router.navigateToEquipmentProcurement(from: navigation, data)
    }
    
    func showSortBottomSheet(from navigation: UINavigationController, _ delegate: SortingBottomSheetDelegate) {
        let bottomSheet = SortingBottomSheet(nibName: String(describing: SortingBottomSheet.self), bundle: nil)
        bottomSheet.delegate = delegate
        bottomSheet.data = self.sortingData
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
    func showConditionFilterBottomSheet(from navigation: UINavigationController, _ delegate: ConditionFilterBottomSheetDelegate) {
        let bottomSheet = ConditionFilterBottomSheet(nibName: String(describing: ConditionFilterBottomSheet.self), bundle: nil)
        bottomSheet.delegate = delegate
        bottomSheet.type = .single
        bottomSheet.assetFilterData = self.conditionFilterData
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
    func showDatePickerBottomSheet(from navigation: UINavigationController, delegate: DatePickerBottomSheetDelegate) {
        let bottomSheet = DatePickerBottomSheet(nibName: String(describing: DatePickerBottomSheet.self), bundle: nil)
        bottomSheet.type = .year
        bottomSheet.delegate = delegate
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
    func showActionBottomSheet(from navigation: UINavigationController, type: RoomRequirementStatusType, _ delegate: ActionRoomReqBottomSheetDelegate, for data: RoomRequirementListData) {
        let bottomSheet = ActionRoomReqBottomSheet(nibName: String(describing: ActionRoomReqBottomSheet.self), bundle: nil)
        bottomSheet.type = type
        bottomSheet.data = data
        bottomSheet.delegate = delegate
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
    func showProgressRoomBottomSheet(from navigation: UINavigationController, for data: [Progress]) {
        let bottomSheet = ProgressRoomReqBottomSheet(nibName: String(describing: ProgressRoomReqBottomSheet.self), bundle: nil)
        bottomSheet.data = data
        router.showBottomSheet(navigation: navigation, view: bottomSheet)
    }
    
}
