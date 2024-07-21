//
//  PreventiveCategoryTVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 30/05/24.
//

import UIKit
import Combine

class PreventiveCategoryTVC: UITableViewCell {
    
    static let identifier = String(describing: PreventiveCategoryTVC.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkBoxImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var selectTypeDateLabel: UILabel!
    @IBOutlet weak var selectDateButton: UIView!
    @IBOutlet weak var selectDateLabel: UILabel!
    @IBOutlet weak var selectDateIconImageView: UIImageView!
    
    var anyCancellable = Set<AnyCancellable>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        containerView.makeCornerRadius(8)
        containerView.addBorder(width: 1, colorBorder: UIColor.customDarkGrayColor)
        selectDateButton.makeCornerRadius(8)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
}

extension PreventiveCategoryTVC {
    
    func setupCell(data: PreventiveCategoryEntity, delegate: PreventiveCategoryCellDelegate, index: Int) {
        self.layoutIfNeeded()
        containerView.addBorder(width: data.isSelected ? 1.5 : 1, colorBorder: data.isSelected ? UIColor.customPrimaryColor : UIColor.customDarkGrayColor)
        titleLabel.text = data.title
        checkBoxImageView.image = UIImage(named: data.isSelected ? "ic_checkbox_ellipse_selected" : "ic_checkbox_ellipse_unselected")
        descriptionLabel.text = data.description
        selectTypeDateLabel.text = data.selectDateTitle
        selectDateIconImageView.image = UIImage(named: data.isSelected ? "ic_calendar_selected" : "ic_calendar_unselected")
        
        if let selectedDate = data.selectedDate, !selectedDate.isEmpty {
            selectDateLabel.text = selectedDate
        } else if let selectedMonth = data.selectedMonth, !selectedMonth.isEmpty {
            selectDateLabel.text = selectedMonth
        } else {
            selectDateLabel.text = data.selectDateTitlePlaceHolder
        }
        
        selectDateButton.gesture()
            .sink { _ in
                delegate.didTapSelectDate(index: index)
            }
            .store(in: &anyCancellable)
    }
    
}
