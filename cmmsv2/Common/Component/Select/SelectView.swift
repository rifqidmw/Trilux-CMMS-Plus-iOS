//
//  SelectView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 14/06/24.
//

import UIKit

enum SelectViewType {
    case plain
    case date
}

class SelectView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectContainerView: UIView!
    @IBOutlet weak var placeholderTitleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        let view = loadNib()
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
        self.selectContainerView.makeCornerRadius(8)
    }
    
}

extension SelectView {
    
    func configure(title: String, placeHolder: String, value: String? = nil, type: SelectViewType? = .plain) {
        self.titleLabel.text = title
        if let value {
            if value.isEmpty {
                self.placeholderTitleLabel.text = placeHolder
            } else {
                self.placeholderTitleLabel.text = value
            }
        } else {
            self.placeholderTitleLabel.text = placeHolder
        }
        self.layoutIfNeeded()
        
        switch type {
        case .plain: break
        case .date:
            self.iconImageView.image = UIImage(named: "ic_calendar_selected")
        default: break
        }
    }
    
}
