//
//  EvidenceEquipmentCVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 21/01/24.
//

import UIKit
import Combine

enum EvidenceEquipmentType {
    case upload
    case view
}

protocol EvidenceEquipmentCellDelegate: AnyObject {
    func didRemoveMedia(_ indexPath: IndexPath)
}

class EvidenceEquipmentCVC: UICollectionViewCell {
    
    static let identifier = String(describing: EvidenceEquipmentCVC.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    @IBOutlet weak var evidenceImageView: UIImageView!
    @IBOutlet weak var removeMediaButton: UIImageView!
    var anyCancellable = Set<AnyCancellable>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.evidenceImageView.makeCornerRadius(8)
    }
    
}

extension EvidenceEquipmentCVC {
    
    func setupCell(url: String?, type: EvidenceEquipmentType = .view, indexPath: IndexPath? = nil, delegate: EvidenceEquipmentCellDelegate? = nil) {
        if let urlString = url, let url = URL(string: urlString) {
            self.evidenceImageView.loadImageUrl(url.absoluteString)
        }
        
        self.removeMediaButton.isHidden = type == .view
        self.removeMediaButton.gesture()
            .sink { _ in
                guard let delegate, let indexPath else { return }
                delegate.didRemoveMedia(indexPath)
            }
            .store(in: &anyCancellable)
    }
    
}
