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
    
    weak var parentView: AssetDetailView?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
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
    
    private func setupBody() {
        bindingData()
    }
    
    private func bindingData() {
        guard let view = self.parentView else { return }
        view.$generalInfoData
            .sink { [weak self] data in
                guard let self, let data else { return }
                self.inventoryNumberView.configureView(title: "Nomor Inventaris", value: data.txtInventaris ?? "-N/A-")
                
                self.toolBrandView.configureView(title: "Merk Alat", value: data.txtBrand ?? "-N/A-")
                
                self.simbadaView.configureView(title: "Simbada", value: data.syncSimbada ?? "-N/A-")
                
                self.serialNumberView.configureView(title: "Serial Number", value: data.txtSerial ?? "-N/A-")
                
                self.toolTypeView.configureView(title: "Tipe Alat", value: data.txtType ?? "-N/A-")
                
                self.distributorView.configureView(title: "Distributor", value: data.txtDistributor ?? "-N/A-")
                
                self.simakView.configureView(title: "Simak", value: data.syncSimak ?? "-N/A-")
                
                self.aspakView.configureView(title: "Aspak", value: data.syncAspak ?? "-N/A-")
            }
            .store(in: &anyCancellable)
        
        view.$technicalData
            .sink { [weak self] data in
                guard let self, let data else { return }
                self.productYearView.configureView(title: "Tahun Produk", value: data.txtThnProduct ?? "-N/A-")
                
                self.yearPurchasingProductView.configureView(title: "Tahun Pembelian", value: data.txtThnPembelian ?? "-N/A-")
                
                self.redualRatioView.configureView(title: "Rasio Sisa", value: data.txtRasioSisaUsia ?? "-N/A-")
                
                self.ageBenefitView.configureView(title: "Usia Manfaat", value: data.txtLife ?? "-N/A-")
            }
            .store(in: &anyCancellable)
    }
    
}
