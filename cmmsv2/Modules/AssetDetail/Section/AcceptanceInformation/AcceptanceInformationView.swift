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
    
    override func didLoad() {
        super.didLoad()
        self.setupView()
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
    
    private func setupView() {
        contractNumberView.configureView(title: "Nomor Kontrak", value: "5690")
        dateContractView.configureView(title: "Tanggal Kontrak", value: "2024-04-26")
        partnerView.configureView(title: "Rekanan", value: "PT. Aku Datang")
        descriptionView.configureView(title: "Keterangan", value: "Belanja modal kedokteran rawat inap")
    }
    
}
