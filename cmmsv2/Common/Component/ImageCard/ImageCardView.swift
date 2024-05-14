//
//  ImageCardView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 21/01/24.
//

import UIKit

class ImageCardView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageCardLabel: UILabel!
    
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
        
        view.makeCornerRadius(8)
        view.addShadow(2, opacity: 0.4)
        imageView.makeCornerRadius(8, .topCurve)
    }
    
}

extension ImageCardView {
    
    func configureView(image: String, label: String) {
        imageView.loadImageUrl(image)
        imageCardLabel.text = label
    }
    
}
