//
//  BaseViewController.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 04/01/24.
//

import UIKit
import Combine
import IQKeyboardManagerSwift
import XLPagerTabStrip

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var isEngineer = false
    var isIPSRS = false
    var isSwipeBackAble = true
    var anyCancellable = Set<AnyCancellable>()
    var pagerTabStripViewController: ButtonBarPagerTabStripViewController?
    var views: [UIViewController] = []
    var api = ApiManager()
    
    let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        view.tag = 8759
        return view
    }()
    
    let loadingView: UIView = {
        let loadView = UIView()
        loadView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        loadView.translatesAutoresizingMaskIntoConstraints = false
        return loadView
    }()
    
    lazy var customLoadingView = CustomLoadingView(frame: .zero)
    
    func showLoadingPopup() {
        DispatchQueue.main.async {
            self.view.addSubview(self.loadingView)
            NSLayoutConstraint.activate([
                self.loadingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                self.loadingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                self.loadingView.topAnchor.constraint(equalTo: self.view.topAnchor),
                self.loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
            
            self.loadingView.addSubview(self.customLoadingView)
            
            self.customLoadingView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.customLoadingView.centerXAnchor.constraint(equalTo: self.loadingView.centerXAnchor),
                self.customLoadingView.centerYAnchor.constraint(equalTo: self.loadingView.centerYAnchor),
                self.customLoadingView.leadingAnchor.constraint(greaterThanOrEqualTo: self.loadingView.leadingAnchor, constant: 16),
                self.customLoadingView.trailingAnchor.constraint(lessThanOrEqualTo: self.loadingView.trailingAnchor, constant: -16),
                self.customLoadingView.heightAnchor.constraint(equalToConstant: 400)
            ])
            
            
            self.customLoadingView.alpha = 0
            self.customLoadingView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            
            UIView.animate(withDuration: 0.3, animations: {
                self.customLoadingView.alpha = 1
                self.customLoadingView.transform = CGAffineTransform.identity
            })
        }
    }
    
    func hideLoadingPopup() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, animations: {
                self.customLoadingView.alpha = 0
                self.customLoadingView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            }) { _ in
                self.customLoadingView.removeFromSuperview()
                self.loadingView.removeFromSuperview()
            }
        }
    }
    
    func reloadTableViewWithAnimation(_ tableView: UITableView) {
        UIView.transition(with: tableView, duration: 0.3, options: .transitionCrossDissolve, animations: {
            tableView.reloadData()
        }, completion: nil)
    }
    
    func reloadCollectionViewWithAnimation(_ collectionView: UICollectionView) {
        UIView.transition(with: collectionView, duration: 0.3, options: .transitionCrossDissolve, animations: {
            collectionView.reloadData()
        }, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        didLoad()
        navigationSetup()
        configureKeyboard()
        listenNotification()
        setupUserRole()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        willAppear()
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = isSwipeBackAble
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        didAppear()
    }
    
    func didLoad() {}
    
    func willAppear() {}
    
    func didAppear() {}
    
    deinit {
        AppLogger.log("Deinit \(String(describing: self))", logType: .kDeinit)
        anyCancellable.removeAll()
    }
    
    func initializePagerTabStripViewController() -> ButtonBarPagerTabStripViewController {
        let pagerTabStripViewController = ButtonBarPagerTabStripViewController()
        pagerTabStripViewController.settings.style.buttonBarBackgroundColor = .clear
        pagerTabStripViewController.settings.style.buttonBarItemBackgroundColor = .clear
        pagerTabStripViewController.settings.style.selectedBarBackgroundColor = .customPrimaryColor
        pagerTabStripViewController.settings.style.buttonBarItemFont = .robotoRegular(14)
        pagerTabStripViewController.settings.style.selectedBarHeight = 4.0
        pagerTabStripViewController.settings.style.buttonBarMinimumLineSpacing = 0
        pagerTabStripViewController.settings.style.buttonBarItemTitleColor = .customDarkGrayColor
        return pagerTabStripViewController
    }
    
    func setupStripTabBar(in containerView: UIView) {
        if pagerTabStripViewController == nil {
            pagerTabStripViewController = initializePagerTabStripViewController()
        }
        
        guard let pagerTabStripViewController = self.pagerTabStripViewController else { return }
        
        pagerTabStripViewController.datasource = self
        pagerTabStripViewController.delegate = self
        
        addChild(pagerTabStripViewController)
        pagerTabStripViewController.view.frame = containerView.bounds
        containerView.addSubview(pagerTabStripViewController.view)
        pagerTabStripViewController.didMove(toParent: self)
    }
    
    func configureKeyboard() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "DONE"
        IQKeyboardManager.shared.toolbarTintColor = .customDarkGrayColor
    }
    
    func navigationSetup() {}
    
    func listenNotification() {
        NotificationCenter.default.publisher(for: .popToRoot)
            .sink(receiveValue: { [weak self] _ in
                guard let self = self,
                      let navigation = self.navigationController
                else { return }
                self.dismiss(animated: true)
                navigation.popToRootViewController(animated: true)
            })
            .store(in: &anyCancellable)
    }
    
    func showOverlay() {
        view.addSubview(overlayView)
        overlayView.frame = view.bounds
        overlayView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        NotificationCenter.default.addObserver(self, selector: #selector(removeOverlay), name: .removeOverlay, object: nil)
        
        UIView.animate(withDuration: 1.0) {
            self.overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        }
    }
    
    @objc func removeOverlay() {
        overlayView.removeFromSuperview()
        NotificationCenter.default.removeObserver(self, name: .removeOverlay, object: nil)
    }
    
    func showOverlaySearch(_ navigationView: UIView) {
        view.insertSubview(overlayView, belowSubview: navigationView)
        
        overlayView.frame = CGRect(x: 0, y: 100, width: CGSize.widthDevice, height: CGSize.heightDevice)
        overlayView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        NotificationCenter.default.addObserver(self, selector: #selector(removeOverlay), name: .removeOverlay, object: nil)
        
        UIView.animate(withDuration: 1.0) {
            self.overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        }
    }
    
    func showAlert(title: String, message: String? = "", completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
        alertController.addAction(action)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func dismissBottomSheet(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.2, animations: {
            self.overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        }) { _ in
            self.dismiss(animated: true) {
                completion?()
            }
        }
    }
    
    private func configureAction() {
        overlayView.gesture()
            .sink { _ in
                self.removeOverlay()
            }
            .store(in: &anyCancellable)
    }
    
    func setupLayout(height: CGFloat) {
        let totalHeight = CGFloat(height)
        NotificationCenter.default.post(name: .contentHeightDidChange, object: nil, userInfo: ["contentHeight": totalHeight])
    }
    
    func observeContentHeight(heightConstraint: NSLayoutConstraint) {
        NotificationCenter.default.addObserver(forName: .contentHeightDidChange, object: nil, queue: .main) { [weak self] notification in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if let height = notification.userInfo?["contentHeight"] as? CGFloat {
                    UIView.animate(withDuration: 0.3) {
                        heightConstraint.constant = height
                        self.view.layoutIfNeeded()
                    }
                }
            }
        }
    }
    
    func setupUserRole() {
        let role = RoleManager.shared.currentUserRole
        switch role {
        case .ipsrs:
            self.isIPSRS = true
            self.isEngineer = false
        case .engineer:
            self.isIPSRS = false
            self.isEngineer = true
        case .unknown:
            break
        }
    }
    
}

extension BaseViewController: PagerTabStripDataSource, PagerTabStripDelegate {
    
    func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return views
    }
    
    func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int) {
        viewController.moveToViewController(at: toIndex, animated: true)
    }
    
}

extension BaseViewController {
    
    func validateUser() {
        api.requestApiPublisher(.getProfile)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished: break
                    case .failure(let error):
                        AppLogger.log(error, logType: .kNetworkResponseError)
                        self.logout()
                    }
                },
                receiveValue: { (userProfile: UserProfileEntity) in
                    if let message = userProfile.message {
                        switch message {
                        case .success: break
                        case .errors:
                            self.logout()
                        default: break
                        }
                    }
                }
            )
            .store(in: &anyCancellable)
    }
    
    func logout() {
        guard let hospital = AppManager.getHospital(),
              let logo = hospital.logo,
              let tagline = hospital.tagline
        else { return }
        let data = HospitalTheme(logo: logo, tagline: tagline)
        
        DispatchQueue.main.async {
            let vc = LoginRouter().showView()
            vc.data = data
            AppManager.deleteObject("isLoggedIn")
            AppManager.deleteObject("valToken")
            
            let rootViewController = UINavigationController(rootViewController: vc)
            UIApplication.shared.setRootViewController(rootViewController)
        }
    }
    
}
