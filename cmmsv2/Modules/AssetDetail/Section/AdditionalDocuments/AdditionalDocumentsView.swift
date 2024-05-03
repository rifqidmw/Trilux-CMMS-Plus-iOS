//
//  AdditionalDocumentsView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 01/05/24.
//

import UIKit
import XLPagerTabStrip

class AdditionalDocumentsView: BaseNonNavigationController, IndicatorInfoProvider {
    
    override func didLoad() {
        super.didLoad()
    }
    
    func indicatorInfo(for pagerTabStripController: XLPagerTabStrip.PagerTabStripViewController) -> XLPagerTabStrip.IndicatorInfo {
        return IndicatorInfo(title: "Dokumen Tambahan")
    }
    
}
