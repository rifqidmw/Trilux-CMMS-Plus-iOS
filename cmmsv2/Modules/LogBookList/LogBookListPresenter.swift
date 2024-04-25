//
//  LogBookPresenter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 17/03/24.
//

import Foundation

class LogBookListPresenter: BasePresenter {
    
    private let interactor: LogBookListInteractor
    private let router = LogBookListRouter()
    
    init(interactor: LogBookListInteractor) {
        self.interactor = interactor
    }
    
    @Published public var logbookList: LogBookListEntity?
    
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    var limit: Int = 20
    var page: Int = 1
    var isCanLoad = true
    var isFetchingMore = false
    
}

extension LogBookListPresenter {
    
    func fetchInitData(date: String) {
        self.fetchLogBookList(limit: self.limit, page: self.page, date: date)
    }
    
    func fetchLogBookList(limit: Int,
                          page: Int,
                          date: String) {
        self.isLoading = true
        interactor.getListLogBook(limit: limit, page: page, date: date)
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
                receiveValue: { logbook in
                    DispatchQueue.main.async {
                        self.logbookList = logbook
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func fetchNextPage(date: String) {
        guard !isFetchingMore && isCanLoad else { return }
        page += 1
        self.fetchLogBookList(limit: self.limit, page: self.page, date: date)
    }
    
}
