//
//  EvidenceEquipmentCVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 21/01/24.
//

import UIKit

class EvidenceEquipmentCVC: UICollectionViewCell {
    
    static let identifier = String(describing: EvidenceEquipmentCVC.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    @IBOutlet weak var evidenceImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.evidenceImageView.makeCornerRadius(8)
    }
    
}

extension EvidenceEquipmentCVC {
    
    func setupCell(url: String?) {
        evidenceImageView.loadImageUrl(url ?? "")
    }
    
}
