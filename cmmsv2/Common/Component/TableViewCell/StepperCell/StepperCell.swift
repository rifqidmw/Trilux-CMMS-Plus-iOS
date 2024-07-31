//
//  StepperCell.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 31/07/24.
//

import UIKit

class StepperCell: UITableViewCell {
    
    static let identifier = String(describing: StepperCell.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    @IBOutlet weak var iconProgressImageView: UIImageView!
    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var trackDescriptionLabel: UILabel!
    @IBOutlet weak var dateContainerView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var timeContainerView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.dateContainerView.makeCornerRadius(8)
        self.separatorView.makeCornerRadius(4)
        self.timeContainerView.makeCornerRadius(8)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
}

extension StepperCell {
    
    func setupCell(data: TrackComplaintData) {
        self.trackTitleLabel.text = data.title?.getStringValue() ?? ""
        self.trackDescriptionLabel.text = data.info
        self.configureProgress(data.title ?? .none)
        if let date = String.parseDate(data.tanggal ?? "") {
            self.dateLabel.text = String.formattedDate(date)
            self.timeLabel.text = String.formattedTime(date)
        }
    }
    
    private func configureProgress(_ info: TrackInfoType) {
        switch info {
        case .created:
            self.iconProgressImageView.image = UIImage(named: "ic_step_not_started")
        case .received:
            self.iconProgressImageView.image = UIImage(named: "ic_step_progress")
        default: break
        }
    }
    
}
