//
//  AddTaskCell.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 08/07/24.
//

import UIKit
import Combine

protocol AddTaskCellDelegate: AnyObject {
    func didTapDeleteTask(_ indexPath: IndexPath)
}

class AddTaskCell: UITableViewCell {
    
    static let identifier = String(describing: AddTaskCell.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var deleteButton: UILabel!
    
    var anyCancellable = Set<AnyCancellable>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = . none
    }
    
}

extension AddTaskCell {
    
    func setupCell(data: TaskLK, index: IndexPath, delegate: AddTaskCellDelegate) {
        self.titleLabel.text = data.lkTask ?? ""
        self.deleteButton.gesture()
            .sink { _ in
                delegate.didTapDeleteTask(index)
            }
            .store(in: &anyCancellable)
    }
    
}
