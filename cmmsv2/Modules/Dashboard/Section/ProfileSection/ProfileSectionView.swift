//
//  ProfileSectionView.swift
//  cmmsv2
//
//  Created by macbook  on 29/08/24.
//

import UIKit

class ProfileSectionView: UIView {
    
    @IBOutlet weak var titleSectionLabel: UILabel!
    @IBOutlet weak var selectEngineerView: SelectView!
    @IBOutlet weak var selectDateView: SelectView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileLineCircleImageView: UIImageView!
    @IBOutlet weak var engineerNameLabel: UILabel!
    
    @IBOutlet weak var workUnitInfoCardView: ProfileInformationCardView!
    @IBOutlet weak var positionInfoCardView: ProfileInformationCardView!
    @IBOutlet weak var phoneInfoCardView: ProfileInformationCardView!
    
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
        self.setupBody()
    }
    
}

extension ProfileSectionView {
    
    private func setupBody() {
        configureView()
        setupAction()
    }
    
    private func configureView() {
        self.titleSectionLabel.text = "Engineer"
        self.selectEngineerView.titleLabel.isHidden = true
        self.selectEngineerView.configure(title: "-", placeHolder: "Engineer")
        self.selectDateView.titleLabel.isHidden = true
        self.selectDateView.configure(title: "-", placeHolder: "Date")
        self.workUnitInfoCardView.configure(image: "ic_name_card_rounded_fill", title: "Unit Kerja", "-")
        self.positionInfoCardView.configure(image: "ic_person_rounded_fill", title: "Jabatan", "-")
        self.phoneInfoCardView.configure(image: "ic_phone_rounded_fill", title: "Nomor Telepon", "-")
        self.engineerNameLabel.text = "Maruf"
    }
    
    private func setupAction() {
        
    }
    
}
