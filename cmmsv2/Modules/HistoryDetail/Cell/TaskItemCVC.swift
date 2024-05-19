//
//  TaskItemCVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 19/05/24.
//

import UIKit

class TaskItemCVC: UICollectionViewCell {
    
    static let identifier = String(describing: TaskItemCVC.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

extension TaskItemCVC {
    
    func setupCell(_ title: String) {
        self.titleLabel.text = title
    }
    
}
