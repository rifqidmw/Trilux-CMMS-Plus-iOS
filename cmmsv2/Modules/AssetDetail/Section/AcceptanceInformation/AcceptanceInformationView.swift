//
//  AcceptanceInformationView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 01/05/24.
//

import UIKit
import XLPagerTabStrip

class AcceptanceInformationView: BaseViewController, IndicatorInfoProvider {
    
    @IBOutlet weak var contractNumberView: InformationCardView!
    @IBOutlet weak var dateContractView: InformationCardView!
    @IBOutlet weak var partnerView: InformationCardView!
    @IBOutlet weak var descriptionView: InformationCardView!
    
    weak var parentView: AssetDetailView?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
    }
    
    override func willAppear() {
        super.willAppear()
        self.setupLayout(height: 300)
    }
    
    func indicatorInfo(for pagerTabStripController: XLPagerTabStrip.PagerTabStripViewController) -> XLPagerTabStrip.IndicatorInfo {
        return IndicatorInfo(title: "Informasi Penerimaan")
    }
    
}

extension AcceptanceInformationView {
    
    private func setupBody() {
        bindingData()
    }
    
    private func bindingData() {
        guard let view = self.parentView else { return }
        view.$acceptanceData
            .sink { [weak self] data in
                guard let self, let data else { return }
                self.contractNumberView.configureView(title: "Nomor Kontrak", value: data.noKontrak ?? "-N/A-")
                
                self.dateContractView.configureView(title: "Tanggal Kontrak", value: data.tanggal ?? "-N/A-")
                
                self.partnerView.configureView(title: "Rekanan", value: data.rekananText ?? "-N/A-")
                
                self.descriptionView.configureView(title: "Keterangan", value: data.desc ?? "-N/A-")
            }
            .store(in: &anyCancellable)
    }
    
}
