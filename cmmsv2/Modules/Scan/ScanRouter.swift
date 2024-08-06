//
//  ScanRouter.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/02/24.
//

import UIKit

class ScanRouter: BaseRouter {
    
    func showView(
        type: ScanType = .asset,
        data: WorkSheetListEntity? = nil,
        request: WorkSheetRequestEntity? = nil,
        delegate: ScanViewDelegate? = nil) -> ScanView {
            let interactor = ScanInteractor()
            let presenter = ScanPresenter(
                interactor: interactor,
                router: self,
                type: type,
                data: data ?? .init(idAsset: ""),
                request: request ?? .init(id: "", action: ""))
            let view = ScanView(nibName: String(describing: ScanView.self), bundle: nil)
            view.presenter = presenter
            view.delegate = delegate
            return view
        }
    
}
