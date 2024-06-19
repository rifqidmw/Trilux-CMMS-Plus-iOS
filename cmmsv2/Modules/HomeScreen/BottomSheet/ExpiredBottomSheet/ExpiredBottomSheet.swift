//
//  ExpiredView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 04/02/24.
//

import Lottie
import UIKit

class ExpiredBottomSheet: BaseNonNavigationController {
    
    @IBOutlet weak var containerCardView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var expiredLabel: UILabel!
    
    private var animation = LottieAnimationView(name: "lottie_expired")
    var expiredDate: String?
    
    override func didLoad() {
        super.didLoad()
        setupBody()
    }
    
}

extension ExpiredBottomSheet {
    
    private func setupBody() {
        setupView()
        setupAnimation()
    }
    
    private func setupView() {
        expiredLabel.text = "Expired: \(expiredDate ?? "Invalid date")"
        
        containerCardView.makeCornerRadius(20)
        containerCardView.addShadow(4)
    }
    
    private func setupAnimation() {
        animation.contentMode = .scaleAspectFit
        animationView.addSubview(animation)
        animation.frame = animationView.bounds
        animation.loopMode = .loop
        animation.play()
    }
    
}
