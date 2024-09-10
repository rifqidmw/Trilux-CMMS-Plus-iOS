//
//  ProfileMenuTVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/01/24.
//

import UIKit

class ProfileMenuTVC: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet weak var menuTitleLabel: UILabel!
    @IBOutlet weak var descriptionTitleLabel: UILabel!
    
    static let identifier = String(describing: ProfileMenuTVC.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.makeCornerRadius(12)
        containerView.makeCornerRadius(12)
        containerView.addShadow(4, position: .bottom, opacity: 0.2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension ProfileMenuTVC {
    
    func setupCell(data: ProfileMenuModel) {
        menuImageView.image = UIImage(named: data.image)
        menuTitleLabel.text = data.title
        descriptionTitleLabel.text = data.desc
    }
    
}
