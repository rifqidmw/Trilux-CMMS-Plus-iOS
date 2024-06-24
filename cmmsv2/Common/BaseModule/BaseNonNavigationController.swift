//
//  BaseNonNavigationController.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 04/01/24.
//

import UIKit
import Combine

class BaseNonNavigationController: UIViewController {
    
    var anyCancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        didLoad()
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
    
    func loadBottomSheeet(view: UIView) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            UIView.animate(withDuration: 0.2, animations: {
                view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            })
        }
    }
    
    func dismissBottomSheet(view: UIView) {
        UIView.animate(withDuration: 0.2, animations: {
            view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        }) { _ in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
