//
//  SparePartTVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 02/06/24.
//

import UIKit
import Combine

protocol SparePartCellDelegate: AnyObject {
    func didTapRemoveSparePart(id: String)
}

class SparePartTVC: UITableViewCell {
    
    static let identifier = String(describing: SparePartTVC.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var deleteLabel: UILabel!
    
    var delegate: SparePartCellDelegate?
    var anyCancellable = Set<AnyCancellable>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
}

extension SparePartTVC {
    
    func setupCell(data: LKData.Sparepart, delegate: SparePartCellDelegate) {
        titleLabel.text = data.partname ?? "-"
        
        let normalText = NSAttributedString.stylizedText("Jumlah: ", font: UIFont.latoRegular(10), color: UIColor.customDarkGrayColor)
        let countText = NSAttributedString.stylizedText(data.jumlah ?? "-", font: UIFont.latoRegular(10), color: UIColor.customPrimaryColor)
        
        let fullAttributedText = NSMutableAttributedString()
        fullAttributedText.append(normalText)
        fullAttributedText.append(countText)
        
        countLabel.attributedText = fullAttributedText
        
        
        deleteLabel.gesture()
            .sink { [weak self] _ in
                guard let self, let delegate = self.delegate else { return }
                delegate.didTapRemoveSparePart(id: data.idPart ?? "")
            }
            .store(in: &anyCancellable)
    }
    
}
