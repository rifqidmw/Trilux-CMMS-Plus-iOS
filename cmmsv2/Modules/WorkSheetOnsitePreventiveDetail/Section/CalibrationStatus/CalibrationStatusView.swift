//
//  CalibrationStatusView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/02/24.
//

import UIKit

class CalibrationStatusView: UIView {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var customHeaderView: CustomHeaderView!
    @IBOutlet weak var dropdownView: DropdownView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    
    var type: WorkSheetOnsitePreventiveDetailType?
    
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
        configureSharedComponent()
    }
    
}

extension CalibrationStatusView {
    
    func configure(type: WorkSheetOnsitePreventiveDetailType, status: String, title: String) {
        self.type = type
        statusLabel.text = status
        dropdownView.configure(title: status)
        customHeaderView.configure(icon: "ic_check_outline", title: title, type: type == .seeOnly
                                   ? .collapsibleAction : .plain)
        
        dropdownView.isHidden = type == .seeOnly ? true : false
        statusView.isHidden = type == .workContinue ? true : false
    }
    
    private func configureSharedComponent() {
        containerView.makeCornerRadius(8)
        containerView.addShadow(4, opacity: 0.2)
    }
    
}
