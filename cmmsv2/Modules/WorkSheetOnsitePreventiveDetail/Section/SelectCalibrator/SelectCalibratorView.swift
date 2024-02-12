//
//  SelectCalibratorView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/02/24.
//

import UIKit

class SelectCalibratorView: UIView {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var customHeaderView: CustomHeaderView!
    @IBOutlet weak var dropDownView: DropdownView!
    
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

extension SelectCalibratorView {
    
    private func configureSharedComponent() {
        containerView.makeCornerRadius(8)
        containerView.addShadow(4, opacity: 0.2)
        customHeaderView.configure(icon: "ic_infinity", title: "Kalibrator", type: .plain)
        dropDownView.configure(title: "Carla Calzoni")
    }
    
}
