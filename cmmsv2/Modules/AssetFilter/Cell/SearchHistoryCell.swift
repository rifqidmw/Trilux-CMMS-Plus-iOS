//
//  SearchHistoryCell.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 28/07/24.
//

import UIKit
import Combine

protocol SearchHistoryCellDelegate {
    func didDeleteSearchItem(idx: UUID)
}

class SearchHistoryCell: UITableViewCell {
    
    static let identifier = String(describing: SearchHistoryCell.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    @IBOutlet weak var iconClockImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var deleteButton: UIImageView!
    var anyCancellable = Set<AnyCancellable>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
}

extension SearchHistoryCell {
    
    func setupCell(title: String, idx: UUID, delegate: SearchHistoryCellDelegate) {
        self.titleLabel.text = title
        self.deleteButton.gesture()
            .sink { _ in
                delegate.didDeleteSearchItem(idx: idx)
            }
            .store(in: &anyCancellable)
    }
    
}
