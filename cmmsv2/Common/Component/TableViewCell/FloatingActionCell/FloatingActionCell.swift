//
//  FloatingActionCell.swift
//  cmmsv2
//
//  Created by macbook  on 15/09/24.
//

import UIKit

struct FloatingActionEntity: Identifiable {
    var id = UUID()
    var image: String
    var title: String
}

class FloatingActionCell: UITableViewCell {
    
    static let identifier = String(describing: FloatingActionCell.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    @IBOutlet weak var containerContentView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.containerContentView.layer.cornerRadius = self.iconImageView.bounds.width / 1
        self.containerContentView.clipsToBounds = true
        self.containerContentView.addShadow(2, opacity: 0.2)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
}

extension FloatingActionCell {
    
    func setupCell(_ data: FloatingActionEntity) {
        self.iconImageView.image = UIImage(systemName: data.image)
        self.titleLabel.text = data.title
    }
    
}
