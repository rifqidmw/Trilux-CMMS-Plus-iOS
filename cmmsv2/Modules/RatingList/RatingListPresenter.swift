//
//  RatingListPresenter.swift
//  cmmsv2
//
//  Created by macbook  on 01/10/24.
//

import Foundation

class RatingListPresenter: BasePresenter {
    
    private let interactor: RatingListInteractor
    private let router = RatingListRouter()
    
    @Published public var ratingList: [RatingData] = []
    @Published public var workSheetDetail: HistoryDetailEntity?
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    var page: Int = 1
    var limit: Int = 20
    var isCanLoad = true
    var isFetchingMore = false
    var woStatus = "finished,rated"
    
    init(interactor: RatingListInteractor) {
        self.interactor = interactor
    }
    
}

extension RatingListPresenter {
    
    func fetchInitialData() {
        self.fetchRatingList(woStatus: self.woStatus, page: self.page, limit: self.limit)
    }
    
    func fetchRatingList(woStatus: String?, page: Int, limit: Int) {
        self.isLoading = true
        interactor.getRatingList(woStatus: woStatus, limit: limit, page: page)
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
                receiveValue: { ratingData in
                    DispatchQueue.main.async {
                        guard let data = ratingData.data,
                              let ratingList = data.wo
                        else { return }
                        self.ratingList.append(contentsOf: ratingList)
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func fetchNextPage() {
        guard !isFetchingMore && isCanLoad else { return }
        page += 1
        fetchRatingList(woStatus: self.woStatus, page: self.page, limit: self.limit)
    }
    
    func fetchWorkSheetDetail(id: String?, completion: (() -> Void)? = nil) {
        self.isLoading = true
        interactor.getWorkSheetNotification(id: id ?? "")
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
                receiveValue: { workSheet in
                    DispatchQueue.main.async {
                        self.workSheetDetail = workSheet
                        completion?()
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
}
