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
    @IBOutlet weak var badgePDFView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var documentImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView.makeCornerRadius(8)
        self.containerView.addShadow(0.1, position: .bottom, opacity: 0.2)
        self.badgePDFView.makeCornerRadius(4)
        self.badgePDFView.addShadow(0.1, position: .bottom, opacity: 0.2)
        self.iconDocumentImageView.makeCornerRadius(4)
        self.iconDocumentImageView.addShadow(0.1, position: .bottom, opacity: 0.2)
    }
    
}

extension AdditionDocumentCVC {
    
    func setupCell(data: File) {
        self.titleLabel.text = data.title
        self.iconDocumentImageView.isHidden = false
        
        if let url = data.url, !url.isEmpty, let documentType = documentType(for: url) {
            switch documentType {
            case .image:
                self.documentImageView.isHidden = false
                self.iconDocumentImageView.isHidden = true
                self.badgePDFView.isHidden = true
                self.documentImageView.loadImageUrl(url)
                self.documentImageView.makeCornerRadius(8)
            case .pdf:
                self.iconDocumentImageView.isHidden = true
                self.badgePDFView.isHidden = false
            }
        }
    }
    
    func documentType(for url: String) -> DocumentType? {
        guard !url.isEmpty else {
            return nil
        }
        let fileExtension = (url as NSString).pathExtension.lowercased()
        switch fileExtension {
        case "jpg", "jpeg", "png":
            return .image
        case "pdf":
            return .pdf
        default:
            return nil
        }
    }
    
}
