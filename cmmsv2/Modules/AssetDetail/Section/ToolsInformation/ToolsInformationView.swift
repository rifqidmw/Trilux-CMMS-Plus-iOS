//
//  ToolsInformationView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 01/05/24.
//

import UIKit
import XLPagerTabStrip

class ToolsInformationView: BaseNonNavigationController, IndicatorInfoProvider {
    
    @IBOutlet weak var inventoryNumberView: InformationCardView!
    @IBOutlet weak var toolBrandView: InformationCardView!
    @IBOutlet weak var productYearView: InformationCardView!
    @IBOutlet weak var yearPurchasingProductView: InformationCardView!
    @IBOutlet weak var redualRatioView: InformationCardView!
    @IBOutlet weak var simbadaView: InformationCardView!
    
    @IBOutlet weak var serialNumberView: InformationCardView!
    @IBOutlet weak var toolTypeView: InformationCardView!
    @IBOutlet weak var distributorView: InformationCardView!
    @IBOutlet weak var ageBenefitView: InformationCardView!
    @IBOutlet weak var simakView: InformationCardView!
    @IBOutlet weak var aspakView: InformationCardView!
    
    override func didLoad() {
        super.didLoad()
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupLayout()
    }
    
    func indicatorInfo(for pagerTabStripController: XLPagerTabStrip.PagerTabStripViewController) -> XLPagerTabStrip.IndicatorInfo {
        return IndicatorInfo(title: "Informasi Alat")
    }
    
}

extension ToolsInformationView {
    
    private func setupView() {
        inventoryNumberView.configureView(title: "Nomor Inventaris", value: "-")
        toolBrandView.configureView(title: "Merk Alat", value: "Suzuki")
        productYearView.configureView(title: "Tahun Produk", value: "2024")
        yearPurchasingProductView.configureView(title: "Tahun Pembelian", value: "2024")
        redualRatioView.configureView(title: "Rasio Sisa", value: "1%")
        simbadaView.configureView(title: "Simbada", value: "-")
        
        serialNumberView.configureView(title: "Serial Number", value: "9-909")
        toolTypeView.configureView(title: "Tipe Alat", value: "GSX")
        distributorView.configureView(title: "Distributor", value: "ABN Indonesia")
        ageBenefitView.configureView(title: "Usia Manfaat", value: "8 Tahun")
        simakView.configureView(title: "Simak", value: "-")
        aspakView.configureView(title: "Aspak", value: "-")
    }
    
    private func setupLayout() {
        let totalHeight = CGFloat(500)
        NotificationCenter.default.post(name: Notification.Name("ContentHeightDidChange"), object: nil, userInfo: ["contentHeight": totalHeight])
    }
    
}
