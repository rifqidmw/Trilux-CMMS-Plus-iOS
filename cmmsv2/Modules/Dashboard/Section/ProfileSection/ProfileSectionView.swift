//
//  ProfileSectionView.swift
//  cmmsv2
//
//  Created by macbook  on 29/08/24.
//

import UIKit
import Combine

protocol ProfileSectionViewDelegate: AnyObject {
    func didTapSelectDate()
}

class ProfileSectionView: UIView {
    
    @IBOutlet weak var engineerView: InformationCardView!
    @IBOutlet weak var selectDateView: SelectView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileLineCircleImageView: UIImageView!
    @IBOutlet weak var engineerNameLabel: UILabel!
    
    @IBOutlet weak var workUnitInfoCardView: ProfileInformationCardView!
    @IBOutlet weak var positionInfoCardView: ProfileInformationCardView!
    @IBOutlet weak var phoneInfoCardView: ProfileInformationCardView!
    
    weak var delegate: ProfileSectionViewDelegate?
    var selectedTechnician: TechnicianEntity?
    var selectedDate: Date?
    var anyCancellable = Set<AnyCancellable>()
    
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
        self.setupAction()
    }
    
}

extension ProfileSectionView {
    
    func configureView(_ data: DashboardEngineer?) {
        self.engineerView.titleLabel.isHidden = true
        self.engineerView.configureView(title: "", value: data?.username ?? "")
        self.selectDateView.titleLabel.isHidden = true
        self.workUnitInfoCardView.configure(image: "ic_name_card_rounded_fill", title: "Unit Kerja", data?.unitKerja ?? "")
        self.positionInfoCardView.configure(image: "ic_person_rounded_fill", title: "Jabatan", data?.jabatan ?? "")
        self.phoneInfoCardView.configure(image: "ic_phone_rounded_fill", title: "Nomor Telepon", data?.kontak ?? "")
        self.engineerNameLabel.text = data?.username ?? ""
        self.profileImageView.loadImageUrl(data?.avatar ?? "")
        self.profileImageView.layer.cornerRadius = self.profileImageView.bounds.width / 2
        self.profileImageView.clipsToBounds = true
        self.profileImageView.layer.masksToBounds = true
        if let selectedDate = selectedDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.dateFormat = "MMMM yyyy"
            selectDateView.configure(title: "", placeHolder: "", value: dateFormatter.string(from: selectedDate), type: .date)
        } else {
            self.selectDateView.configure(title: "", placeHolder: "", value: String.getCurrentDateString("MMMM yyyy"), type: .date)
        }
    }
    
    private func setupAction() {
        self.selectDateView.gesture()
            .sink { [weak self] _ in
                guard let self, let delegate = self.delegate else { return }
                delegate.didTapSelectDate()
            }
            .store(in: &anyCancellable)
    }
    
    func updateSelectedValues() {
        if let selectedDate = selectedDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.dateFormat = "MMMM yyyy"
            selectDateView.configure(title: "", placeHolder: "", value: dateFormatter.string(from: selectedDate), type: .date)
        }
    }
    
}
