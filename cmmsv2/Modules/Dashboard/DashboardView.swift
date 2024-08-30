//
//  DashboardView.swift
//  cmmsv2
//
//  Created by macbook  on 28/08/24.
//

import UIKit

class DashboardView: BaseViewController {
    
    @IBOutlet weak var customNavigationView: CustomNavigationView!
    
    var presenter: DashboardPresenter?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
    }
    
}

extension DashboardView {
    
    private func setupBody() {
        setupView()
        setupAction()
    }
    
    private func setupView() {
        customNavigationView.configure(toolbarTitle: "Dashboard", type: .plain)
    }
    
    private func setupAction() {
        customNavigationView.arrowLeftBackButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let navigation = self.navigationController
                else { return }
                navigation.popViewController(animated: true)
            }
            .store(in: &anyCancellable)
    }
    
}
