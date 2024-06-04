//
//  CustomLoadingView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 04/06/24.
//

import UIKit
import Lottie

class CustomLoadingView: UIView {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var iconCoffeeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerAnimationView: UIView!
    private var animationView = LottieAnimationView(name: "lottie_spinner")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        let view = loadNib()
        view.frame = self.bounds
        self.addSubview(view)
        self.setupBody()
    }
    
}

extension CustomLoadingView {
    
    private func setupBody() {
        configureSharedComponent()
        setupAnimation()
    }
    
    private func configureSharedComponent() {
        self.containerView.makeCornerRadius(16)
        self.containerView.addShadow(2, opacity: 0.4)
    }
    
    private func setupAnimation() {
        animationView.contentMode = .scaleAspectFit
        containerAnimationView.addSubview(animationView)
        animationView.frame = containerAnimationView.bounds
        animationView.loopMode = .loop
        animationView.play()
    }
    
}
