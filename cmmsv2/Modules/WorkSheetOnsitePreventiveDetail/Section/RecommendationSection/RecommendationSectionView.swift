//
//  RecommendationSectionView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/02/24.
//

import UIKit

class RecommendationSectionView: UIView {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var containerTextField: UIView!
    @IBOutlet weak var recommendationTextField: UITextField!
    @IBOutlet weak var customHeaderView: CustomHeaderView!
    @IBOutlet weak var recommendationLabel: UILabel!
    
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

extension RecommendationSectionView {
    
    private func configureSharedComponent() {
        containerView.makeCornerRadius(8)
        containerView.addShadow(4, opacity: 0.2)
        containerTextField.makeCornerRadius(8)
    }
    
    func configure(type: WorkSheetOnsitePreventiveDetailType, text: String) {
        self.type = type
        recommendationLabel.text = text
        customHeaderView.configure(icon: "ic_statistic_down", title: "Evaluasi & Rekomendasi", type: type == .seeOnly
                                   ? .collapsibleAction : .plain)
        containerTextField.isHidden = type == .seeOnly ? true : false
        recommendationLabel.isHidden = type == .workContinue ? true : false
    }
    
}
