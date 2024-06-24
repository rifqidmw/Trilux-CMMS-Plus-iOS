//
//  SelectTechnicialCell.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 14/06/24.
//

import UIKit

class SelectTechnicialCell: UITableViewCell {
    
    @IBOutlet weak var checkBoxImageView: UIImageView!
    @IBOutlet weak var arrowIconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = String(describing: SelectTechnicialCell.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
}

extension SelectTechnicialCell {
    
    func setupCell(data: TechnicianEntity, type: SelectTechnicianBottomSheetType, isSelected: Bool = false) {
        self.titleLabel.text = data.name
        switch type {
        case .selectOne:
            arrowIconImageView.isHidden = false
            checkBoxImageView.isHidden = true
        case .selectMultiple:
            arrowIconImageView.isHidden = true
            checkBoxImageView.isHidden = false
            checkBoxImageView.image = UIImage(named: isSelected ? "checked_checkbox" : "unchecked_checkbox")
        }
    }
    
}
