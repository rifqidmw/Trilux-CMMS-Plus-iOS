//
//  BaseNonNavigationController.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 04/01/24.
//

import UIKit
import Combine
import IQKeyboardManagerSwift

class BaseNonNavigationController: UIViewController {
    
    var anyCancellable = Set<AnyCancellable>()
    var isEngineer = false
    var isIPSRS = false
    
    let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        view.tag = 8759
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        didLoad()
        configureKeyboard()
        setupUserRole()
        AppLogger.log(String(describing: self), logType: .kNavigation)
    }
    
    func didLoad() { }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: .removeOverlay, object: nil)
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
    
    func showBottomSheet() {
        view.insertSubview(overlayView, at: 0)
        overlayView.frame = view.bounds
        overlayView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            UIView.animate(withDuration: 0.2, animations: {
                self.overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            })
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
    
    func configureKeyboard() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "DONE"
        IQKeyboardManager.shared.toolbarTintColor = .customDarkGrayColor
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
