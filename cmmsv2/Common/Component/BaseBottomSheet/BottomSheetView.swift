//
//  BottomSheetView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/01/24.
//

import UIKit

class BottomSheetView: UIView {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var handleBarView: UIView!
    @IBOutlet weak var handleBarArea: UIView!
    
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
        
        self.handleBarView.makeCornerRadius(4)
        view.makeCornerRadius(32, .topCurve)
        view.addShadow(4, position: .top, color: UIColor.customDarkGrayColor.cgColor, opacity: 0.2)
        self.sendSubviewToBack(view)
    }
    
}

extension BottomSheetView {
    
    func configure(type: BottomSheetType = .plain) {
        switch type {
        case .plain:
            break
        case .withoutHandleBar:
            handleBarView.isHidden = true
        }
    }
    
}

enum BottomSheetType {
    case plain
    case withoutHandleBar
}
