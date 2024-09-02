//
//  StatusOverviewPanelView.swift
//  cmmsv2
//
//  Created by macbook  on 01/09/24.
//

import UIKit

class StatusOverviewPanelView: UIView {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconStatisticImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
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
        self.addSubview(view)
        self.iconImageView.makeCornerRadius(8)
    }
    
}

extension StatusOverviewPanelView {
    
    func configure(
        icon: String,
        title: String,
        iconStatistic: String,
        description: String,
        summary: String) {
            self.iconImageView.image = UIImage(named: icon)
            self.titleLabel.text = title
            self.iconStatisticImageView.image = UIImage(named: iconStatistic)
            self.descriptionLabel.text = description
            self.summaryLabel.text = summary
        }
    
}
