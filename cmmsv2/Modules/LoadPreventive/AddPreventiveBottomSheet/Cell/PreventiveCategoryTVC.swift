//
//  PreventiveCategoryTVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 30/05/24.
//

import UIKit

struct PreventiveCategoryEntity {
    var isSelected = false
    let title: String
    let description: String
    let selectDateTitle: String
    let selectDateTitlePlaceHolder: String
}

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
    
    func setupCell(data: PreventiveCategoryEntity) {
        containerView.addBorder(width: 1, colorBorder: data.isSelected ? UIColor.customPrimaryColor : UIColor.customDarkGrayColor)
        titleLabel.text = data.title
        checkBoxImageView.image = UIImage(named: data.isSelected ? "ic_checkbox_ellipse_selected" : "ic_checkbox_ellipse_unselected")
        descriptionLabel.text = data.description
        selectTypeDateLabel.text = data.selectDateTitle
        selectDateLabel.text = data.selectDateTitlePlaceHolder
        selectDateIconImageView.image = UIImage(named: data.isSelected ? "ic_calendar_selected" : "ic_calendar_unselected")
    }
    
}
