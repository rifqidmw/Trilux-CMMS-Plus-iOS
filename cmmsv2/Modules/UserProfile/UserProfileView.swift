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
    var user: User?
    var cameraSelectedType: CameraSelectionType?
    var media: MediaProfileEntity?
    var signature: SignatureEntity?
    var data: [ProfileMenuModel] = profileMenuData
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.validateUser()
    }
    
    override func willAppear() {
        super.willAppear()
        self.fetchInitData()
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
                
                self.user = data
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
        
        presenter.$isLoadProfile
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                guard let self else { return }
                isLoading ? self.showLoadingPopup() : self.hideLoadingPopup()
            }
            .store(in: &anyCancellable)
    }
    
    private func setupView() {
        guard let tagLine = UserDefaults.standard.string(forKey: "tagLine") else { return }
        tagLineLabel.text = tagLine
        navigationView.configure(toolbarTitle: "Profil Pengguna", type: .plain)
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
                      let navigation = self.navigationController
                else { return }
                navigation.popViewController(animated: true)
            }
            .store(in: &anyCancellable)
        
        logoutButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let presenter,
                      let navigation = self.navigationController
                else { return }
                presenter.showLogoutPopUp(navigation: navigation, delegate: self)
            }
            .store(in: &anyCancellable)
        
        changeImageButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let presenter,
                      let navigation = self.navigationController
                else { return }
                presenter.showUploadMediaBottomSheet(navigation: navigation, delegate: self)
            }
            .store(in: &anyCancellable)
        
        copyToClipboardButton.gesture()
            .sink { [weak self] _ in
                guard let self else { return }
                let phoneNumber = userPhoneNumberLabel.text ?? ""
                
                if !phoneNumber.isEmpty {
                    UIPasteboard.general.string = phoneNumber
                    self.showAlert(title: "Text disalin", message: "Nomor telepon disalin")
                }
            }
            .store(in: &anyCancellable)
    }
    
    private func setupSkeleton() {
        [
            userProfileImageView,
            userNameLabel,
            tagLineLabel,
            copyToClipboardButton,
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
            copyToClipboardButton,
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
              let navigation = self.navigationController,
              let data = self.user
        else { return }
        
        switch indexPath.row {
        case 0:
            presenter.navigateToEditProfile(navigation: navigation, data: data)
        case 1:
            presenter.navigateToChangePassword(navigation: navigation)
        case 2:
            presenter.showBottomSheetSignature(navigation: navigation, data: data, delegate: self)
        default: break
        }
    }
    
}
