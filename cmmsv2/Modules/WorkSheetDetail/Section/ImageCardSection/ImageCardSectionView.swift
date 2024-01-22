//
//  ImageCardSection.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 21/01/24.
//

import UIKit

class ImageCardSectionView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var containerDetailView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var moreButton: GeneralButton!
    
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
        configureSharedComponent()
    }
    
}

extension ImageCardSectionView {
    
    private func configureSharedComponent() {
        imageView.makeCornerRadius(12)
        containerDetailView.makeCornerRadius(8)
        containerDetailView.addShadow(2, opacity: 0.4)
        moreButton.configure(title: "Selengkapnya")
        moreButton.makeCornerRadius(8)
        moreButton.addShadow(4, color: UIColor.customPrimaryColor.cgColor, opacity: 0.2)
    }
    
    func configure(data: WorkSheetCardEntity) {
        imageView.image = UIImage(named: data.image)
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        codeLabel.text = data.code
    }
    
}
