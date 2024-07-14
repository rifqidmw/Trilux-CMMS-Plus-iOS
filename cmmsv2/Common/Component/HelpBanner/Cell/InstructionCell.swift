//
//  InstructionCell.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 28/06/24.
//

import UIKit

class InstructionCell: UITableViewCell {
    
    static let identifier = String(describing: InstructionCell.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
}

extension InstructionCell {
    
    func setupCell(title: String) {
        self.titleLabel.text = title
    }
    
}
