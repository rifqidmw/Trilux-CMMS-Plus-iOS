//
//  CategoryCardCVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 07/01/24.
//

import UIKit

class CategoryCardCVC: UICollectionViewCell {
    
    @IBOutlet weak var categoryImageContainerView: UIView!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var badgeView: UIView!
    
    static let identifier = String(describing: CategoryCardCVC.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

extension CategoryCardCVC {
    
    func setupCell(data: CategoryModel) {
        categoryImageView.image = UIImage(named: data.image)
        categoryLabel.text = data.title
        badgeView.isHidden = !data.isUpdated
        
        categoryImageContainerView.makeCornerRadius(12)
        categoryImageContainerView.addShadow(2, position: .bottom, color: UIColor.customDarkGray.cgColor, opacity: 0.2)
        badgeView.makeCornerRadius(8, [.layerMinXMinYCorner, .layerMaxXMaxYCorner])
    }
    
}
