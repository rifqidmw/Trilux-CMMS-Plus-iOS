//
//  BaseViewController.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 04/01/24.
//

import UIKit
import Combine
import IQKeyboardManagerSwift

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var isSwipeBackAble = true
    var anyCancellable = Set<AnyCancellable>()
    
    let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        view.tag = 8759
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        didLoad()
        navigationSetup()
        configureKeyboard()
        listenNotification()
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
    
    private func configureAction() {
        overlayView.gesture()
            .sink { _ in
                self.removeOverlay()
            }
            .store(in: &anyCancellable)
    }
}

