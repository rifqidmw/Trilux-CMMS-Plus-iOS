//
//  SplashScreenView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 02/02/24.
//

import UIKit

class SplashScreenView: BaseViewController {
    
    var presenter: SplashScreenPresenter?
    
    @IBOutlet var backgroundView: BackgroundView!
    @IBOutlet weak var containerView: UIStackView!
    
    private let isRegistered = UserDefaults.standard.bool(forKey: "isRegistered")
    private let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    
    override func didLoad() {
        super.didLoad()
        setupBody()
    }
    
}

extension SplashScreenView {
    
    private func setupBody() {
        fetchInitData()
        bindingData()
        setupView()
    }
    
    private func fetchInitData() {
        guard let presenter = self.presenter else { return }
        presenter.fetchInitData()
    }
    
    private func setupView() {
        self.backgroundView.backgroundType = .splash
    }
    
    private func bindingData() {
        guard let presenter = self.presenter else { return }
        presenter.$userData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                guard let self = self,
                      let data = data,
                      let message = data.message
                else { return }
                
                if message == .success && self.isLoggedIn && self.isRegistered {
                    presenter.navigateToHomeScreen()
                }
            }
            .store(in: &anyCancellable)
        
        presenter.$isError
            .sink { [weak self] isError in
                guard let self = self else { return }
                let logo = UserDefaults.standard.string(forKey: "triluxLogo") ?? ""
                let tagline = UserDefaults.standard.string(forKey: "tagLine") ?? ""
                let hospitalTheme = HospitalTheme(logo: logo, tagline: tagline)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    if isError {
                        if !self.isRegistered && !self.isLoggedIn {
                            presenter.navigateToRegistrationHospital()
                        } else if !self.isLoggedIn {
                            presenter.navigateToLoginPage(data: hospitalTheme)
                        } else {
                            UserDefaults.standard.removeObject(forKey: "isLoggedIn")
                            presenter.navigateToLoginPage(data: hospitalTheme)
                        }
                    }
                }
            }
            .store(in: &anyCancellable)
    }
    
}
