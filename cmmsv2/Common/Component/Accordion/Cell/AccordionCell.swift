//
//  TestingAccordiionTVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 23/05/24.
//

import UIKit

class AccordionCell: UITableViewCell {
    
    static let identifier = String(describing: AccordionCell.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    @IBOutlet weak var customHeaderView: CustomHeaderView!
    @IBOutlet weak var containerContentView: UIView!
    @IBOutlet weak var contentAccordionView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
}

extension AccordionCell {
    
    func setupCell(data: AccordionEntity) {
        switch data.type {
        case .collapsibleAction:
            self.customHeaderView.configure(icon: data.icon, title: data.title, type: .collapsibleAction, collapseIcon: data.isCollapsed ? "ic_uncollapsible_accordion" : "ic_collapse_accordion")
        case .dismissSwitch:
            self.customHeaderView.configure(icon: data.icon, title: data.title, type: .dismissSwitch, radioButtonIcon: data.isCollapsed ? "ic_radio_button_on" : "ic_radio_button_off")
        default:
            self.customHeaderView.configure(icon: data.icon, title: data.title, type: data.type)
        }
        
        self.containerContentView.isHidden = data.type == .dismissSwitch ? data.isCollapsed : !data.isCollapsed
        
        if let view = data.view {
            self.contentAccordionView.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                view.leadingAnchor.constraint(equalTo: self.contentAccordionView.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: self.contentAccordionView.trailingAnchor),
                view.topAnchor.constraint(equalTo: self.contentAccordionView.topAnchor),
                view.bottomAnchor.constraint(equalTo: self.contentAccordionView.bottomAnchor)
            ])
        }
    }
    
}
