//
//  LabelTVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 08/02/24.
//

import UIKit

class LabelTVC: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = String(describing: LabelTVC.self)
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

extension LabelTVC {
    
    func setupCell(label: String) {
        titleLabel.text = label
    }
    
}
