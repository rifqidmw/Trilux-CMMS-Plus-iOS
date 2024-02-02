//
//  UIApplication+Ext.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 04/01/24.
//

import Foundation
import UIKit

extension UIApplication {
    
    class func topViewController(viewController: UIViewController? = UIApplication.shared.connectedScenes
        .compactMap { $0 as? UIWindowScene }
        .flatMap { $0.windows }
        .first(where: { $0.isKeyWindow })?
        .rootViewController) -> UIViewController? {
            
            if let nav = viewController as? UINavigationController {
                return topViewController(viewController: nav.visibleViewController)
            }
            
            if let tab = viewController as? UITabBarController,
               let selected = tab.selectedViewController {
                return topViewController(viewController: selected)
            }
            
            if let presented = viewController?.presentedViewController {
                return topViewController(viewController: presented)
            }
            
            return viewController
        }
    
    func setRootViewController(_ viewController: UIViewController) {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            window.rootViewController = viewController
        }, completion: nil)
    }
    
}
