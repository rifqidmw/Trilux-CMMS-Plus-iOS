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
    
    weak var parentView: AssetDetailView?
    
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
        bindingData()
    }
    
    private func bindingData() {
        guard let view = self.parentView else { return }
        view.$generalInfoData
            .sink { [weak self] data in
                guard let self, let data else { return }
                self.ownerInfoView.configure(infoTitle: "Pemilik", icon: "ic_user_rounded_square", detailInfoTitle: data.txtRuangan ?? "-N/A-", detailInfoDesc: data.txtSubRuangan ?? "-N/A-")
                
                self.locationInfoView.configure(infoTitle: "Lokasi", icon: "ic_pin_location_rounded_square", detailInfoTitle: data.txtLokasiInstalasi ?? "-N/A-", detailInfoDesc: data.txtLokasiName ?? "-N/A-")
            }
            .store(in: &anyCancellable)
        
        view.$technicalData
            .sink { [weak self] data in
                guard let self, let data else { return }
                self.budgetInfoView.configure(type: .withoutDesc, infoTitle: "Sumber Pendanaan", icon: "ic_stack_rounded_square", detailInfoTitle: data.txtSumber ?? "-N/A-")
            }
            .store(in: &anyCancellable)
        
        view.$costData
            .sink { [weak self] data in
                guard let self, let data else { return }
                self.priceInfoView.configure(type: .withoutDesc, infoTitle: "Biaya", icon: "ic_dollar_rounded_square", detailInfoTitle: data.txtIIC ?? "-N/A-")
            }
            .store(in: &anyCancellable)
    }
    
}
