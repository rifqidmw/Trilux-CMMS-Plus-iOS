//
//  ToolsInformationView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 01/05/24.
//

import UIKit
import XLPagerTabStrip

class ToolsInformationView: BaseViewController, IndicatorInfoProvider {
    
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
    
    override func willAppear() {
        super.willAppear()
        self.setupLayout(height: 500)
    }
    
    func indicatorInfo(for pagerTabStripController: XLPagerTabStrip.PagerTabStripViewController) -> XLPagerTabStrip.IndicatorInfo {
        return IndicatorInfo(title: "Informasi Alat")
    }
    
}

extension ToolsInformationView {
    
    private func setupView() {
        inventoryNumberView.configureView(title: "Nomor Inventaris", value: "-N/A-")
        toolBrandView.configureView(title: "Merk Alat", value: "-N/A-")
        productYearView.configureView(title: "Tahun Produk", value: "-N/A-")
        yearPurchasingProductView.configureView(title: "Tahun Pembelian", value: "-N/A-")
        redualRatioView.configureView(title: "Rasio Sisa", value: "-N/A-")
        simbadaView.configureView(title: "Simbada", value: "-N/A-")
        
        serialNumberView.configureView(title: "Serial Number", value: "-N/A-")
        toolTypeView.configureView(title: "Tipe Alat", value: "-N/A-")
        distributorView.configureView(title: "Distributor", value: "-N/A-")
        ageBenefitView.configureView(title: "Usia Manfaat", value: "-N/A-")
        simakView.configureView(title: "Simak", value: "-N/A-")
        aspakView.configureView(title: "Aspak", value: "-N/A-")
    }
    
}
