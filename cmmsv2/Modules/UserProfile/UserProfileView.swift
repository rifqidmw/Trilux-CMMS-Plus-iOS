//
//  UserProfileView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/01/24.
//

import UIKit
import SkeletonView

class UserProfileView: BaseViewController {
    
    @IBOutlet weak var navigationView: CustomNavigationView!
    @IBOutlet weak var containerProfileView: UIView!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tagLineLabel: UILabel!
    @IBOutlet weak var userPhoneNumberLabel: UILabel!
    @IBOutlet weak var copyToClipboardButton: UIView!
    @IBOutlet weak var changeImageButton: GeneralButton!
    @IBOutlet weak var workUnitView: InformationCardView!
    @IBOutlet weak var positionView: InformationCardView!
    @IBOutlet weak var jobView: InformationCardView!
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
        fetchInitData()
        bindingData()
        setupView()
        setupAction()
        setupTableView()
    }
    
    private func fetchInitData() {
        guard let presenter else { return }
        presenter.fetchInitData()
    }
    
    private func bindingData() {
        guard let presenter else { return }
        presenter.$userProfile
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                guard let self,
                      let data = data,
                      let workUnit = data.txtUnitKerja,
                      let position = data.txtJabatan,
                      let job = data.txtJob,
                      let profileImage = data.valImage,
                      let userName = data.txtName,
                      let phoneNumber = data.txtTelepon
                else { return }
                
                self.userProfileImageView.loadImageUrl(profileImage)
                self.userNameLabel.text = userName.capitalized
                self.userPhoneNumberLabel.text = phoneNumber
                self.workUnitView.configureView(title: "Unit Kerja", value: workUnit)
                self.positionView.configureView(title: "Jabatan", value: position)
                self.jobView.configureView(title: "Job", value: job)
            }
            .store(in: &anyCancellable)
        
        presenter.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                guard let self else { return }
                if isLoading {
                    setupSkeleton()
                } else {
                    hideSkeletonAnimation()
                }
            }
            .store(in: &anyCancellable)
    }
    
    private func setupView() {
        guard let tagLine = UserDefaults.standard.string(forKey: "tagLine") else { return }
        tagLineLabel.text = tagLine
        navigationView.configure(plainTitle: "Profil Pengguna", type: .plain)
        containerProfileView.makeCornerRadius(12)
        containerProfileView.addShadow(6, opacity: 0.2)
        userProfileImageView.makeCornerRadius(12)
        changeImageButton.configure(title: "Ganti Gambar")
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
                presenter.showLogoutPopUp(navigation: navigation, delegate: self)
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
        
        copyToClipboardButton.gesture()
            .sink { [weak self] _ in
                guard let self else { return }
                let phoneNumber = userPhoneNumberLabel.text ?? ""
                
                if !phoneNumber.isEmpty {
                    UIPasteboard.general.string = phoneNumber
                    self.showAlert(title: "Copy to clipboard", message: "Phone number copied to clipboard")
                }
            }
            .store(in: &anyCancellable)
    }
    
    private func setupSkeleton() {
        [
            userProfileImageView,
            userNameLabel,
            tagLineLabel,
            userPhoneNumberLabel,
            workUnitView,
            positionView,
            jobView
        ].forEach {
            $0.isSkeletonable = true
            $0.showGradientSkeleton()
        }
    }
    
    private func hideSkeletonAnimation() {
        [
            userProfileImageView,
            userNameLabel,
            tagLineLabel,
            userPhoneNumberLabel,
            workUnitView,
            positionView,
            jobView
        ].forEach {
            $0?.hideSkeleton()
        }
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

extension UserProfileView: LogoutPopUpBottomSheetDelegate {
    
    func didTapLogout() {
        guard let presenter,
              let logo = UserDefaults.standard.string(forKey: "triluxLogo"),
              let tagline = UserDefaults.standard.string(forKey: "tagLine"),
              let navigation = self.navigationController
        else { return }
        let data = HospitalTheme(logo: logo, tagline: tagline)
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")
        UserDefaults.standard.removeObject(forKey: "valToken")
        presenter.navigateToLoginPage(navigation: navigation, data: data)
    }
    
}
