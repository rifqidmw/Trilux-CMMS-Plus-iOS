//
//  ToastView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 10/02/24.
//

import UIKit
import Combine

protocol ToastViewDelegate: AnyObject {
    func didTapCloseButton()
    func didTapSeeMore()
}

class ToastView: UIView {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var closeButton: UIImageView!
    
    var anyCancellable = Set<AnyCancellable>()
    weak var delegate: ToastViewDelegate?
    
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
        setupAction()
    }
    
}

extension ToastView {
    
    private func configureSharedComponent() {
        containerView.makeCornerRadius(8)
    }
    
    private func setupAction() {
        closeButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let delegate = self.delegate
                else { return }
                delegate.didTapCloseButton()
            }
            .store(in: &anyCancellable)
    }
    
}
