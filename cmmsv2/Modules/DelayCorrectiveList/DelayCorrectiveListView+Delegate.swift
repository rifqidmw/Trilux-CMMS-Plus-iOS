//
//  DelayCorrectiveListView+Delegate.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 14/06/24.
//

import UIKit

extension DelayCorrectiveListView: CorrectiveCellDelegate {
    
    func didTapContinueCorrective(data: Complaint, title: CorrectiveTitleType) {
        AppLogger.log("-- THIS IS COMPLAINT DATA: \(data)")
    }
    
}
