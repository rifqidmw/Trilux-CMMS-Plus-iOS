//
//  ScanView+Delegate.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 20/07/24.
//

import UIKit

extension ScanView: WorkSheetDetailViewDelegate {
    
    func didSaveWorkSheet() {
        guard let delegate else { return }
        delegate.didNavigateAfterSaveWorkSheet()
    }
    
}
