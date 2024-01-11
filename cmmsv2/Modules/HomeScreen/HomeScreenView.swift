// 
//  HomeScreenView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 07/01/24.
//

import UIKit

class HomeScreenView: BaseViewController {
    
    @IBOutlet weak var navigationView: CustomNavigationView!
    @IBOutlet weak var searchButton: GeneralButton!
    @IBOutlet weak var categoryView: CategorySectionView!
    @IBOutlet weak var informationCardView: UIView!
    @IBOutlet weak var closeButton: UIImageView!
    @IBOutlet weak var scanButon: UIView!
    
    var presenter: HomeScreenPresenter?

    override func didLoad() {
        super.didLoad()
        setupBody()
    }

}

extension HomeScreenView {
    
    private func setupBody() {
        setupView()
        setupAction()
    }
    
    private func setupView() {
        navigationView.configure(username: "John Doe", headline: "RSUD John Doe", type: .homeToolbar)
        searchButton.configure(type: .searchbutton)
        informationCardView.makeCornerRadius(8)
        scanButon.makeCornerRadius(28)
        scanButon.addShadow(4, opacity: 0.4)
        categoryView.delegate = self
    }
    
    private func setupAction() {
        scanButon.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let navigation = self.navigationController,
                      let presenter = self.presenter
                else {
                    return
                }
                
                self.showOverlay()
                presenter.showBottomSheetDetailInformation(navigation: navigation)
            }
            .store(in: &anyCancellable)
    }
    
}

extension HomeScreenView: HomeScreenCategoryDelegate {
    
    func didTapAllCategory() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        self.showOverlay()
        presenter.showBottomSheetAllCategories(navigation: navigation)
    }
    
    func didTapContract() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        self.showOverlay()
        presenter.showBottomSheetContract(navigation: navigation)
    }
    
    func didTapAsset() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        self.showOverlay()
        presenter.showBottomSheetAsset(navigation: navigation)
    }
    
    func didTapAssetMedic() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        self.showOverlay()
        presenter.showBottomSheetAssetMedic(navigation: navigation)
    }
    
    func didTapAssetNonMedic() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        self.showOverlay()
        presenter.showBottomSheetAssetNonMedic(navigation: navigation)
    }
    
}
