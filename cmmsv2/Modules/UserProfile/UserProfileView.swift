// 
//  UserProfileView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/01/24.
//

import UIKit

class UserProfileView: BaseViewController {
    
    @IBOutlet weak var navigationView: CustomNavigationView!
    @IBOutlet weak var containerProfileView: UIView!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var userPhoneNumberLabel: UILabel!
    @IBOutlet weak var copyToClipboardButton: UIView!
    @IBOutlet weak var changeImageButton: GeneralButton!
    @IBOutlet weak var workUnitView: BriefInformationCardView!
    @IBOutlet weak var positionView: BriefInformationCardView!
    @IBOutlet weak var jobView: BriefInformationCardView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var logoutButton: GeneralButton!
    
    var presenter: UserProfilePresenter?
    var data: [ProfileMenuModel] = profileMenuData

    override func didLoad() {
        super.didLoad()
        setupBody()
    }

}

extension UserProfileView {
    
    private func setupBody() {
        setupView()
        setupAction()
        setupTableView()
    }
    
    private func setupView() {
        navigationView.configure(plainTitle: "Profil Pengguna", type: .plain)
        containerProfileView.makeCornerRadius(12)
        containerProfileView.addShadow(6, opacity: 0.2)
        userProfileImageView.makeCornerRadius(12)
        changeImageButton.configure(title: "Ganti Gambar")
        workUnitView.configureView(title: "Unit Kerja", value: "Logistik")
        positionView.configureView(title: "Jabatan", value: "Ka. Instalasi")
        jobView.configureView(title: "Job", value: "Pengelola Barang")
        logoutButton.configure(title: "Keluar", backgroundColor: UIColor.indicatorColor3, titleColor: UIColor.customRed)
        
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            versionLabel.text = "Versi \(appVersion)"
        } else {
            versionLabel.text = "Tidak dapat mengambil versi aplikasi"
        }
    }
    
    private func setupAction() {
        navigationView.arrowLeftBackButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let presenter,
                      let navigation = self.navigationController
                else { return }
                
                presenter.backToPreviousPage(navigation: navigation)
            }
            .store(in: &anyCancellable)
        
        logoutButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let presenter,
                      let navigation = self.navigationController
                else { return }
                
                self.showOverlay()
                presenter.showLogoutPopUp(navigation: navigation)
            }
            .store(in: &anyCancellable)
        
        changeImageButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let presenter,
                      let navigation = self.navigationController
                else { return }
                
                self.showOverlay()
                presenter.showBottomSheetChangePicture(navigation: navigation)
            }
            .store(in: &anyCancellable)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProfileMenuTVC.nib, forCellReuseIdentifier: ProfileMenuTVC.identifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
    }
    
}

extension UserProfileView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileMenuTVC.identifier, for: indexPath) as? ProfileMenuTVC
        else {
            return UITableViewCell()
        }
        
        cell.setupCell(data: data[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        
        switch indexPath.row {
        case 0:
            presenter.navigateToEditProfile(navigation: navigation)
        case 1:
            presenter.navigateToChangePassword(navigation: navigation)
        default: break
        }
    }
    
}
