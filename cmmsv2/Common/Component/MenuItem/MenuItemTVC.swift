//
//  MedicItemTVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 11/01/24.
//

import UIKit

class MenuItemTVC: UITableViewCell {
    
    @IBOutlet weak var medicAssetImageView: UIImageView!
    @IBOutlet weak var medicAssetTitleLabel: UILabel!
    @IBOutlet weak var medicAssetSubTitleLabel: UILabel!
    
    static let identifier = String(describing: MenuItemTVC.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension MenuItemTVC {
    
    func setupCell(data: MenuModel) {
        medicAssetImageView.image = UIImage(named: data.image)
        medicAssetTitleLabel.text = data.title
        medicAssetSubTitleLabel.text = data.subTitle
    }
    
}
