//
//  MonitoringInformationView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/08/24.
//

import UIKit
import XLPagerTabStrip

class MonitoringInformationView: BaseViewController, IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: XLPagerTabStrip.PagerTabStripViewController) -> XLPagerTabStrip.IndicatorInfo {
        return IndicatorInfo(title: "Pemantauan Fungsi")
    }
    
    override func didLoad() {
        super.didLoad()
    }
    
}
