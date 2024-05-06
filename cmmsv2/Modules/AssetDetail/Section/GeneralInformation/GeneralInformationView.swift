//
//  GeneralInformationView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 01/05/24.
//

import UIKit
import XLPagerTabStrip

class GeneralInformationView: BaseViewController, IndicatorInfoProvider {
    
    @IBOutlet weak var ownerInfoView: InformationDetailView!
    @IBOutlet weak var locationInfoView: InformationDetailView!
    @IBOutlet weak var budgetInfoView: InformationDetailView!
    @IBOutlet weak var priceInfoView: InformationDetailView!
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
    }
    
    override func willAppear() {
        super.willAppear()
        self.setupLayout(height: 400)
    }
    
    func indicatorInfo(for pagerTabStripController: XLPagerTabStrip.PagerTabStripViewController) -> XLPagerTabStrip.IndicatorInfo {
        return IndicatorInfo(title: "Informasi Umum")
    }
    
}

extension GeneralInformationView {
    
    private func setupBody() {
        self.setupView()
    }
    
    private func setupView() {
        ownerInfoView.configure(infoTitle: "Pemilik", icon: "ic_user_rounded_square", detailInfoTitle: "-N/A-", detailInfoDesc: "-N/A-")
        locationInfoView.configure(type: .withoutDesc, infoTitle: "Lokasi", icon: "ic_pin_location_rounded_square", detailInfoTitle: "-N/A-")
        budgetInfoView.configure(type: .withoutDesc, infoTitle: "-N/A-", icon: "ic_stack_rounded_square", detailInfoTitle: "-N/A-")
        priceInfoView.configure(type: .withoutDesc, infoTitle: "Harga", icon: "ic_dollar_rounded_square", detailInfoTitle: "-N/A-")
    }
    
}
