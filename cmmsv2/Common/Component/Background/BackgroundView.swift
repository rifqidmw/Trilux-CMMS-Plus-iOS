//
//  BackgroundView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 07/01/24.
//

import UIKit

class BackgroundView: UIView {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var downwardWaveImageView: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var upwardImageView: UIImageView!
    
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
