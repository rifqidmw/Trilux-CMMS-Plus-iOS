//
//  BaseViewController.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 04/01/24.
//

import UIKit
import Combine

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
    
}

