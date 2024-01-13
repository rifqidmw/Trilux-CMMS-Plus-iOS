//
//  BackgroundView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 07/01/24.
//

import UIKit

class BackgroundView: UIView {
    
    @IBOutlet weak var homeBackgroundView: UIView!
    @IBOutlet weak var ellipseBackgroundImageView: UIImageView!
    
    @IBOutlet weak var splashBackgroundView: UIView!
    @IBOutlet weak var splashBackgroundImageView: UIImageView!
    @IBOutlet weak var waveDownwardImageView: UIImageView!
    @IBOutlet weak var triluxLogoImageView: UIImageView!
    @IBOutlet weak var waveUpwardImageView: UIImageView!
    
    var backgroundType: BackgroundType = .home {
        didSet {
            configureBackgroundType()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        let contentView = loadNib()
        contentView.frame = self.bounds
        self.addSubview(contentView)
        self.sendSubviewToBack(contentView)
    }
    
}

extension BackgroundView {
    
    private func configureBackgroundType() {
        switch backgroundType {
        case .home:
            homeBackgroundView.isHidden = false
            splashBackgroundView.isHidden = true
        case .splash:
            splashBackgroundView.isHidden = false
            homeBackgroundView.isHidden = true
        }
    }
    
}

enum BackgroundType {
    case splash
    case home
}
