//
//  StatusFilterCell.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 24/06/24.
//

import UIKit

class StatusFilterCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = String(describing: StatusFilterCell.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.makeCornerRadius(8)
    }
    
}

extension StatusFilterCell {
    
    func configure(data: StatusFilterEntity, isSelected: Bool) {
        titleLabel.text = data.status?.getStringValue().capitalized
        titleLabel.textColor = isSelected ? UIColor.customPrimaryColor : UIColor.customDarkGrayColor
        self.backgroundColor = isSelected ? UIColor.customSecondaryColor : UIColor.customLightGrayColor
    }
    
}
