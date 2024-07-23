//
//  SelectionTVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/07/24.
//

import UIKit

enum SelectionCellType {
    case plain
    case withDesc
}

class SelectionTVC: UITableViewCell {
    
    static let identifier = String(describing: SelectionTVC.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var iconArrowImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
}

extension SelectionTVC {
    
    func setupCell(title: String, description: String? = nil, type: SelectionCellType = .plain) {
        self.titleLabel.text = title
        self.descriptionLabel.isHidden = type == .plain ? true : false
        if let description = description {
            self.descriptionLabel.text = description
        }
    }
    
}
