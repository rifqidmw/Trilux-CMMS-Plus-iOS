//
//  PartnerCell.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 22/06/24.
//

import UIKit

class PartnerCell: UITableViewCell {
    
    static let identifier = String(describing: PartnerCell.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkBoxImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
}

extension PartnerCell {
    
    func setupCell(data: TechnicianEntity, order: Int) {
        titleLabel.text = "\(order + 1). \(data.name ?? "")"
        checkBoxImageView.image = UIImage(named: data.isSelected ? "checked_checkbox" : "unchecked_checkbox")
    }
    
}
