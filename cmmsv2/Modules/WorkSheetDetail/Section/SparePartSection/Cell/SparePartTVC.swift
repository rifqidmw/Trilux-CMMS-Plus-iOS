//
//  SparePartTVC.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 02/06/24.
//

import UIKit
import Combine

protocol SparePartCellDelegate: AnyObject {
    func didTapRemoveSparePart(_ indexPath: IndexPath)
}

class SparePartTVC: UITableViewCell {
    
    static let identifier = String(describing: SparePartTVC.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var deleteLabel: UILabel!
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
    
    func setupCell(name: String?, total: String?, indexPath: IndexPath, delegate: SparePartCellDelegate, activity: WorkSheetActivityType) {
        titleLabel.text = name ?? "-"
        
        let normalText = NSAttributedString.stylizedText("Jumlah: ", font: UIFont.latoRegular(10), color: UIColor.customDarkGrayColor)
        let countText = NSAttributedString.stylizedText(total ?? "-", font: UIFont.latoRegular(10), color: UIColor.customPrimaryColor)
        
        let fullAttributedText = NSMutableAttributedString()
        fullAttributedText.append(normalText)
        fullAttributedText.append(countText)
        
        countLabel.attributedText = fullAttributedText
        
        deleteLabel.isHidden = (activity == .view)
        
        deleteLabel.gesture()
            .sink { _ in
                delegate.didTapRemoveSparePart(indexPath)
            }
            .store(in: &anyCancellable)
    }
    
}
