//
//  UIViewController+Ext.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 04/01/24.
//

import UIKit

extension UIViewController {
    
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as? AppDelegate ?? AppDelegate()
    }
    
    func addChildToParent(_ child: UIViewController) {
        AppLogger.log("\(self) ⬆️⬆️ \(child)", logType: .kNavigation)
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func removeChild() {
        guard parent != nil else { return }
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        return instantiateFromNib()
        }
    
}

// MARK: - Citing from (https://github.com/SwifterSwift/SwifterSwift/blob/master/Sources/SwifterSwift/UIKit/UIViewControllerExtensions.swift)
extension UIViewController {
        /// SwifterSwift: Check if ViewController is onscreen and not hidden.
    var isVisible: Bool {
            // http://stackoverflow.com/questions/2777438/how-to-tell-if-uiviewcontrollers-view-is-visible
        return isViewLoaded && view.window != nil
    }
    
        /// SwifterSwift: Helper method to present a UIViewController as a popover.
        ///
        /// - Parameters:
        ///   - popoverContent: the view controller to add as a popover.
        ///   - sourcePoint: the point in which to anchor the popover.
        ///   - size: the size of the popover. Default uses the popover preferredContentSize.
        ///   - delegate: the popover's presentationController delegate. Default is nil.
        ///   - animated: Pass true to animate the presentation; otherwise, pass false.
        ///   - completion: The block to execute after the presentation finishes. Default is nil.
    func presentPopover(
        _ popoverContent: UIViewController,
        sourcePoint: CGPoint,
        size: CGSize? = nil,
        delegate: UIPopoverPresentationControllerDelegate? = nil,
        animated: Bool = true,
        completion: (() -> Void)? = nil) {
            popoverContent.modalPresentationStyle = .popover
            
            if let size = size {
                popoverContent.preferredContentSize = size
            }
            
            if let popoverPresentationVC = popoverContent.popoverPresentationController {
                popoverPresentationVC.sourceView = view
                popoverPresentationVC.sourceRect = CGRect(origin: sourcePoint, size: .zero)
                popoverPresentationVC.delegate = delegate
            }
            
            present(popoverContent, animated: animated, completion: completion)
        }
}

