//
//  FullScreenPictureView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 21/01/24.
//

import UIKit

class FullScreenPictureView: BaseViewController {
    
    @IBOutlet weak var navigationView: CustomNavigationView!
    @IBOutlet weak var imageView: UIImageView!
    
    var presenter: FullScreenPicturePresenter?
    var titlePage: String?
    var image: String?
    
    override func didLoad() {
        super.didLoad()
        setupBody()
    }
    
}

extension FullScreenPictureView {
    
    private func setupBody() {
        setupView()
        setupAction()
    }
    
    private func setupView() {
        guard let image else { return }
        navigationView.configure(plainTitle: titlePage, type: .plain)
        imageView.loadImageUrl(image)
    }
    
    private func setupAction() {
        navigationView.arrowLeftBackButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let navigation = self.navigationController
                else { return }
                navigation.popViewController(animated: true)
            }
            .store(in: &anyCancellable)
    }
    
}
