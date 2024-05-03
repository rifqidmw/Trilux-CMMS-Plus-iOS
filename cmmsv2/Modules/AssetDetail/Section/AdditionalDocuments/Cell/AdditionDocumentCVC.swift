//
//  AdditionDocumentCVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 04/05/24.
//

import UIKit

class AdditionDocumentCVC: UICollectionViewCell {
    
    static let identifier = String(describing: AdditionDocumentCVC.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var iconDocumentImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView.makeCornerRadius(8)
        self.containerView.addShadow(0.4)
    }
    
}

extension AdditionDocumentCVC {
    
    func setupCell(data: AdditionalDocument) {
        self.titleLabel.text = data.title
    }
    
}
