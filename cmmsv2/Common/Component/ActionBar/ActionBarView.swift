//
//  ActionBarView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 11/02/24.
//

import UIKit
import Combine

@objc protocol ActionBarViewDelegate: AnyObject {
    @objc optional func didTapFirstAction()
    @objc optional func didTapSecondAction()
    @objc optional func didTapThirdAction()
    @objc optional func didTapFourthAction()
}

class ActionBarView: UIView {
    
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var firstContainerActionStackView: UIStackView!
    @IBOutlet weak var firstButtonAction: UIView!
    @IBOutlet weak var firstActionIconImageView: UIImageView!
    @IBOutlet weak var firstActionTitleLabel: UILabel!
    @IBOutlet weak var secondContainerActionStackView: UIStackView!
    @IBOutlet weak var secondButtonAction: UIView!
    @IBOutlet weak var secondActionIconImageView: UIImageView!
    @IBOutlet weak var secondActionTitleLabel: UILabel!
    @IBOutlet weak var thirdContainerActionStackView: UIStackView!
    @IBOutlet weak var thirdButtonAction: UIView!
    @IBOutlet weak var thirdActionIconImageView: UIImageView!
    @IBOutlet weak var thirdActionTitleLabel: UILabel!
    @IBOutlet weak var fourthContainerActionStackView: UIStackView!
    @IBOutlet weak var fourthButtonAction: UIView!
    @IBOutlet weak var fourthActionIconImageView: UIImageView!
    @IBOutlet weak var fourthActionTitleLabel: UILabel!
    
    weak var delegate: ActionBarViewDelegate?
    private var activeButton: UIView?
    var anyCancellable = Set<AnyCancellable>()
    
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
        setupAction()
        configureSharedComponent()
    }
    
}

extension ActionBarView {
    
    func configure(
        firstIcon: String? = nil,
        firstTitle: String? = nil,
        secondIcon: String? = nil,
        secondTitle: String? = nil,
        thirdIcon: String? = nil,
        thirdTitle: String? = nil,
        fourthIcon: String? = nil,
        fourthTitle: String? = nil) {
            self.firstContainerActionStackView.isHidden = firstTitle?.isEmpty ?? true
            self.firstActionIconImageView.image = UIImage(systemName: firstIcon ?? "")
            self.firstActionTitleLabel.text = firstTitle ?? ""
            
            self.secondContainerActionStackView.isHidden = secondTitle?.isEmpty ?? true
            self.secondActionIconImageView.image = UIImage(systemName: secondIcon ?? "")
            self.secondActionTitleLabel.text = secondTitle ?? ""
            
            self.thirdContainerActionStackView.isHidden = thirdTitle?.isEmpty ?? true
            self.thirdActionIconImageView.image = UIImage(systemName: thirdIcon ?? "")
            self.thirdActionTitleLabel.text = thirdTitle ?? ""
            
            self.fourthContainerActionStackView.isHidden = fourthTitle?.isEmpty ?? true
            self.fourthActionIconImageView.image = UIImage(systemName: fourthIcon ?? "")
            self.fourthActionTitleLabel.text = fourthTitle ?? ""
        }
    
    private func configureSharedComponent() {
        self.addShadow(1, position: .top, opacity: 0.2)
    }
    
    private func setupAction() {
        firstButtonAction.gesture()
            .sink { [weak self] _ in
                guard let self = self,
                      let delegate = self.delegate
                else { return }
                self.handleButtonTap(button: self.firstButtonAction, iconImageView: self.firstActionIconImageView, titleLabel: self.firstActionTitleLabel, delegate: delegate)
                delegate.didTapFirstAction?()
            }
            .store(in: &anyCancellable)
        
        secondButtonAction.gesture()
            .sink { [weak self] _ in
                guard let self = self,
                      let delegate = self.delegate
                else { return }
                self.handleButtonTap(button: self.secondButtonAction, iconImageView: self.secondActionIconImageView, titleLabel: self.secondActionTitleLabel, delegate: delegate)
                delegate.didTapSecondAction?()
            }
            .store(in: &anyCancellable)
        
        thirdButtonAction.gesture()
            .sink { [weak self] _ in
                guard let self = self,
                      let delegate = self.delegate
                else { return }
                self.handleButtonTap(button: self.thirdButtonAction, iconImageView: self.thirdActionIconImageView, titleLabel: self.thirdActionTitleLabel, delegate: delegate)
                delegate.didTapThirdAction?()
            }
            .store(in: &anyCancellable)
        
        fourthButtonAction.gesture()
            .sink { [weak self] _ in
                guard let self = self,
                      let delegate = self.delegate
                else { return }
                self.handleButtonTap(button: self.fourthButtonAction, iconImageView: self.fourthActionIconImageView, titleLabel: self.fourthActionTitleLabel, delegate: delegate)
                delegate.didTapFourthAction?()
            }
            .store(in: &anyCancellable)
    }
    
    private func handleButtonTap(button: UIView, iconImageView: UIImageView, titleLabel: UILabel, delegate: ActionBarViewDelegate) {
        if activeButton == button {
            deselectActiveButton()
            activeButton = nil
        } else {
            deselectActiveButton()
            activateButton(button: button, iconImageView: iconImageView, titleLabel: titleLabel)
        }
    }
    
    private func activateButton(button: UIView, iconImageView: UIImageView, titleLabel: UILabel) {
        activeButton = button
        iconImageView.tintColor = .customPrimaryColor
        titleLabel.textColor = .customPrimaryColor
    }
    
    private func deselectActiveButton() {
        guard let activeButton = activeButton else { return }
        
        let iconImageView = activeButton.subviews.compactMap { $0 as? UIImageView }.first
        let titleLabel = activeButton.subviews.compactMap { $0 as? UILabel }.first
        
        iconImageView?.tintColor = .customPlaceholderColor
        titleLabel?.textColor = .customPlaceholderColor
    }
    
}
