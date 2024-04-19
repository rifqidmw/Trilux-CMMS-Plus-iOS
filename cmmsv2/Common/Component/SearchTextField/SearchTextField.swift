//
//  SearchTextField.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 18/04/24.
//

import UIKit

class SearchTextField: UIView {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    
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
        self.containerView.makeCornerRadius(8)
        self.containerView.addShadow(0.4)
    }
    
}
