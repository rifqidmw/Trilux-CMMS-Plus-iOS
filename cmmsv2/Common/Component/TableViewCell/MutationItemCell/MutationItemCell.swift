//
//  MutationItemCell.swift
//  cmmsv2
//
//  Created by macbook  on 16/09/24.
//

import UIKit

class MutationItemCell: UITableViewCell {
    
    static let identifier = String(describing: MutationItemCell.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    @IBOutlet weak var containerContentStackView: UIStackView!
    @IBOutlet weak var mutationImageView: UIImageView!
    @IBOutlet weak var serialNumberLabel: UILabel!
    @IBOutlet weak var firstRoomLabel: UILabel!
    @IBOutlet weak var secondRoomLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.containerContentStackView.makeCornerRadius(8)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
}

extension MutationItemCell {
    
    func setupCell(_ image: String?, firstRoom: String?, secondRoom: String?, serialNumber: String?) {
        self.mutationImageView.loadImageUrl(image ?? "")
        self.mutationImageView.makeCornerRadius(8)
        self.serialNumberLabel.text = serialNumber ?? "-"
        let firstRoomTitle = NSAttributedString.stylizedText("Ruangan: ", font: UIFont.robotoRegular(10), color: UIColor.customPlaceholderColor)
        let firstRoom = NSAttributedString.stylizedText(firstRoom ?? "-", font: UIFont.robotoBold(12), color: UIColor.customDarkGrayColor)
        
        let fullFirstRoomTitle = NSMutableAttributedString()
        fullFirstRoomTitle.append(firstRoomTitle)
        fullFirstRoomTitle.append(firstRoom)
        self.firstRoomLabel.attributedText = fullFirstRoomTitle
        
        let secondRoomTitle = NSAttributedString.stylizedText("Ruangan: ", font: UIFont.robotoRegular(10), color: UIColor.customPlaceholderColor)
        let secondRoom = NSAttributedString.stylizedText(secondRoom ?? "-", font: UIFont.robotoBold(12), color: UIColor.customDarkGrayColor)
        
        let fullSecondRoomTitle = NSMutableAttributedString()
        fullSecondRoomTitle.append(secondRoomTitle)
        fullSecondRoomTitle.append(secondRoom)
        self.secondRoomLabel.attributedText = fullSecondRoomTitle
    }
    
}
