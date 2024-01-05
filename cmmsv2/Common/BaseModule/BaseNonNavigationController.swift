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
    }

}
