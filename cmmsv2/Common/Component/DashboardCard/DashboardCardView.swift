//
//  DashboardCardView.swift
//  cmmsv2
//
//  Created by macbook  on 30/08/24.
//

import UIKit
import Combine

protocol DashboardCardViewDelegate: AnyObject {
    func didTapDashboardCard()
}

class DashboardCardView: UIView {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var iconDashboardCardImageView: UIImageView!
    @IBOutlet weak var dashboardCardTitleLabel: UILabel!
    @IBOutlet weak var dashboardCardSummaryLabel: UILabel!
    
    var anyCancellable = Set<AnyCancellable>()
    weak var delegate: DashboardCardViewDelegate?
    
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
        self.setupBody()
    }
    
}

extension DashboardCardView {
    
    private func setupBody() {
        configureView()
        setupAction()
    }
    
    private func configureView() {
        self.containerView.makeCornerRadius(16)
        self.containerView.addShadow(2.0, opacity: 0.2)
    }
    
    private func setupAction() {
        self.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let delegate = self.delegate
                else { return }
                delegate.didTapDashboardCard()
            }
            .store(in: &anyCancellable)
    }
    
    func configure(image: String, title: String, _ value: String) {
        self.iconDashboardCardImageView.image = UIImage(named: image)
        self.dashboardCardTitleLabel.text = title
        self.dashboardCardSummaryLabel.text = value
    }
    
}
