//
//  InformationDetailView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 02/05/24.
//

import UIKit

enum InformationDetailType {
    case withDesc
    case withoutDesc
}

class InformationDetailView: UIView {
    
    @IBOutlet weak var infoTitleLabel: UILabel!
    @IBOutlet weak var detailInfoIconImageView: UIImageView!
    @IBOutlet weak var detailInfoTitleLabel: UILabel!
    @IBOutlet weak var detailInfoDescLabel: UILabel!
    
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
    }
    
}

extension InformationDetailView {
    
    func configure(type: InformationDetailType = .withDesc,
                   infoTitle: String,
                   icon: String,
                   detailInfoTitle: String,
                   detailInfoDesc: String? = nil) {
        self.infoTitleLabel.text = infoTitle
        self.detailInfoIconImageView.image = UIImage(named: icon)
        self.detailInfoTitleLabel.text  = detailInfoTitle
        if let detailDesc = detailInfoDesc {
            self.detailInfoDescLabel.isHidden = false
            self.detailInfoDescLabel.text = detailDesc
        }
    }
    
}
