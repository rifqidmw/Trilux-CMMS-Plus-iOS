//
//  TaskItemTVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 02/06/24.
//

import UIKit

class TaskItemTVC: UITableViewCell {
    
    static let identifier = String(describing: TaskItemTVC.self)
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

extension TaskItemTVC {
    
    func setupCell(title: String?) {
        titleLabel.text = title ?? "-"
    }
    
}
