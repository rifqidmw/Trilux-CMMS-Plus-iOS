//
//  TimeGroupHeaderCRV.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 18/02/24.
//

import UIKit
import SkeletonView

class TimeGroupHeaderCRV: UICollectionReusableView {
    
    @IBOutlet weak var timeLabel: UILabel!
    
    static let identifier = String(describing: TimeGroupHeaderCRV.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        timeLabel.isSkeletonable = true
        timeLabel.showAnimatedGradientSkeleton()
    }
    
}

extension TimeGroupHeaderCRV {
    
    func configure(date: String) {
        timeLabel.hideSkeleton()
        timeLabel.text = date
    }
    
}
