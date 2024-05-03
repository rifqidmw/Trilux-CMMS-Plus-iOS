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
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupLayout()
    }
    
    func indicatorInfo(for pagerTabStripController: XLPagerTabStrip.PagerTabStripViewController) -> XLPagerTabStrip.IndicatorInfo {
        return IndicatorInfo(title: "Informasi Umum")
    }
    
}

extension GeneralInformationView {
    
    private func setupView() {
        ownerInfoView.configure(infoTitle: "Pemilik", icon: "ic_user_rounded_square", detailInfoTitle: "Pelayanan Rawat Jalan", detailInfoDesc: "Ruangan Klinik Spesialis Penyakit Dalam")
        locationInfoView.configure(type: .withoutDesc, infoTitle: "Lokasi", icon: "ic_pin_location_rounded_square", detailInfoTitle: "Gudang Logistik")
        budgetInfoView.configure(type: .withoutDesc, infoTitle: "Sumber Pendanaan", icon: "ic_stack_rounded_square", detailInfoTitle: "PT. Trilux Sukses Abadi")
        priceInfoView.configure(type: .withoutDesc, infoTitle: "Harga", icon: "ic_dollar_rounded_square", detailInfoTitle: "Rp. 3.200.000")
    }
    
    private func setupLayout() {
        let totalHeight = CGFloat(400)
        NotificationCenter.default.post(name: Notification.Name("ContentHeightDidChange"), object: nil, userInfo: ["contentHeight": totalHeight])
    }
    
}
