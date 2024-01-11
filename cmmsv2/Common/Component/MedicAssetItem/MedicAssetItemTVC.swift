//
//  MedicItemTVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 11/01/24.
//

import UIKit

class MedicAssetItemTVC: UITableViewCell {
    
    @IBOutlet weak var medicAssetImageView: UIImageView!
    @IBOutlet weak var medicAssetTitleLabel: UILabel!
    @IBOutlet weak var medicAssetSubTitleLabel: UILabel!
    
    static let identifier = String(describing: MedicAssetItemTVC.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension MedicAssetItemTVC {
    
    func setupCell(data: MedicAssetModel) {
        medicAssetImageView.image = UIImage(named: data.image)
        medicAssetTitleLabel.text = data.title
        medicAssetSubTitleLabel.text = data.subTitle
    }
    
}
