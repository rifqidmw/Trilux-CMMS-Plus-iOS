//
//  CustomHeaderView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/02/24.
//

import UIKit
import Combine

enum CustomHeaderType {
    case plain
    case plainWithoutSeparator
    case actionLabel
    case dismissSwitch
    case collapsibleAction
    case collapsibleWithCount
    case formHeader
}

@objc protocol CustomHeaderDelegate: AnyObject {
    @objc optional func didTapActionLabel()
    @objc optional func didTapSwitchButton()
    @objc optional func didTapCollapse()
}

class CustomHeaderView: UIView {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var containerTitleView: UIStackView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var containerSwitchButton: UIStackView!
    @IBOutlet weak var switchButton: UIImageView!
    @IBOutlet weak var dismissLabel: UILabel!
    @IBOutlet weak var collapseAccordionIconImageView: UIImageView!
    @IBOutlet weak var containerCollapsibleActionCountView: UIStackView!
    @IBOutlet weak var collapsibleAccordionCountImageView: UIImageView!
    @IBOutlet weak var countView: UIView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    
    var anyCancellable = Set<AnyCancellable>()
    weak var delegate: CustomHeaderDelegate?
    
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
        containerView.makeCornerRadius(8, .topCurve)
        countView.makeCornerRadius(12)
        setupAction()
    }
    
}

extension CustomHeaderView {
    
    func configure(icon: String? = nil,
                   title: String,
                   labelAction: String? = nil,
                   count: Int? = nil,
                   type: CustomHeaderType,
                   collapseIcon: String? = "ic_collapse_accordion",
                   radioButtonIcon: String? = "ic_radio_button_off") {
        self.layoutIfNeeded()
        titleLabel.text = title
        iconImageView.image = UIImage(named: icon ?? "ic_trilux_logo_splash")
        actionLabel.text = labelAction
        countLabel.text = count?.description
        
        switch type {
        case .plain:
            actionLabel.isHidden = true
        case .plainWithoutSeparator:
            separatorView.isHidden = true
            actionLabel.isHidden = true
        case .actionLabel:
            actionLabel.isHidden = false
        case .dismissSwitch:
            containerSwitchButton.isHidden = false
            switchButton.image = UIImage(named: radioButtonIcon ?? "ic_radio_button_off")
        case .collapsibleAction:
            collapseAccordionIconImageView.isHidden = false
            collapseAccordionIconImageView.image = UIImage(named: collapseIcon ?? "ic_collapse_accordion")
        case .collapsibleWithCount:
            containerCollapsibleActionCountView.isHidden = false
        case .formHeader:
            separatorView.isHidden = true
            actionLabel.isHidden = true
            containerView.backgroundColor = UIColor.customPrimaryColor
            titleLabel.textColor = UIColor.white
            iconImageView.isHidden = true
            configureConstraint()
        }
    }
    
    private func setupAction() {
        actionLabel.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let delegate
                else { return }
                delegate.didTapActionLabel?()
            }
            .store(in: &anyCancellable)
        
        switchButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let delegate
                else { return }
                delegate.didTapSwitchButton?()
            }
            .store(in: &anyCancellable)
        
        Publishers.Merge(collapseAccordionIconImageView.gesture(), collapsibleAccordionCountImageView.gesture())
            .sink { [weak self] _ in
                guard let self,
                      let delegate
                else { return }
                delegate.didTapCollapse?()
            }
            .store(in: &anyCancellable)
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            containerTitleView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            containerTitleView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            containerTitleView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            containerTitleView.trailingAnchor.constraint(equalTo: containerView.layoutMarginsGuide.trailingAnchor, constant: -16)
        ])
    }
    
}
