//
//  ProgressRoomCell.swift
//  cmmsv2
//
//  Created by macbook  on 08/10/24.
//

import UIKit

class ProgressRoomCell: UITableViewCell {
    
    static let identifier = String(describing: ProgressRoomCell.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    @IBOutlet weak var stepperIconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
}

extension ProgressRoomCell {
    
    func setupCell(title: String?, description: String?, isComplete: Bool = false) {
        self.titleLabel.text = title ?? "-"
        self.descriptionLabel.text = description ?? "-"
        self.stepperIconImageView.image = UIImage(named: isComplete ? "ic_step_complete" : "ic_step_not_started")
    }
    
}
