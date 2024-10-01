//
//  RatingCell.swift
//  cmmsv2
//
//  Created by macbook  on 01/10/24.
//

import UIKit
import SkeletonView

class RatingCell: UITableViewCell {
    
    static let identifier = String(describing: RatingCell.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstStarIconImageView: UIImageView!
    @IBOutlet weak var secondStarIconImageView: UIImageView!
    @IBOutlet weak var thirdStarIconImageView: UIImageView!
    @IBOutlet weak var fourthStarIconImageView: UIImageView!
    @IBOutlet weak var fifthStarIconImageView: UIImageView!
    @IBOutlet weak var serialNumberLabel: UILabel!
    @IBOutlet weak var containerRateStarStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.containerStackView.makeCornerRadius(8)
        self.showAnimationSkeleton()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
}

extension RatingCell {
    
    private func showAnimationSkeleton() {
        [self.dateLabel,
         self.titleLabel,
         self.serialNumberLabel].forEach {
            $0.isSkeletonable = true
            $0.showAnimatedGradientSkeleton()
        }
    }
    
    private func hideAnimationSkeleton() {
        [self.dateLabel,
         self.titleLabel,
         self.serialNumberLabel].forEach {
            $0.hideSkeleton()
        }
    }
    
    func setupCell(date: String?, title: String?, rating: Int?, serialNumber: String?) {
        self.hideAnimationSkeleton()
        self.dateLabel.text = date ?? "-"
        self.titleLabel.text = title ?? "-"
        self.serialNumberLabel.text = serialNumber ?? "-"
        self.configureStars(for: rating ?? 0)
    }
    
    private func configureStars(for rating: Int) {
        let filledStar = UIImage(named: "ic_star_fill")
        let emptyStar = UIImage(named: "ic_star_opacity")
        
        let stars = [firstStarIconImageView, secondStarIconImageView, thirdStarIconImageView, fourthStarIconImageView, fifthStarIconImageView]
        
        for (index, star) in stars.enumerated() {
            star?.image = (index < rating) ? filledStar : emptyStar
        }
    }
    
}
