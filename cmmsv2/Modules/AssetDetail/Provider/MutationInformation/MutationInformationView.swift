//
//  MutationInformationView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 01/05/24.
//

import UIKit
import XLPagerTabStrip

class MutationInformationView: BaseViewController, IndicatorInfoProvider {
    
    @IBOutlet weak var roomInfoView: InformationDetailView!
    @IBOutlet weak var acceptanceInfoView: InformationCardView!
    @IBOutlet weak var mutationToolsInfoView: InformationCardView!
    @IBOutlet weak var deletionInfoView: InformationCardView!
    
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
        return IndicatorInfo(title: "Informasi Mutasi")
    }
    
}

extension MutationInformationView {
    
    private func setupBody() {
        bindingData()
    }
    
    private func bindingData() {
        guard let view = self.parentView else { return }
        view.$generalInfoData
            .sink { [weak self] data in
                guard let self, let data else { return }
                self.roomInfoView.configure(type: .withDesc, infoTitle: "Ruangan", icon: "ic_user_rounded_square", detailInfoTitle: data.txtLokasiInstalasi ?? "-N/A-", detailInfoDesc: data.txtLokasiName ?? "-N/A-")
            }
            .store(in: &anyCancellable)
        
        view.$costData
            .sink { [weak self] data in
                guard let self, let data else { return }
                self.acceptanceInfoView.configureView(title: "Data Penerimaan", value: data.txtNilaiMMEL ?? "-N/A-")
                
                self.mutationToolsInfoView.configureView(title: "Mutasi Alat", value: data.txtFaktorMEL ?? "-N/A-")
                
                self.deletionInfoView.configureView(title: "Penghapusan", value: data.txtPengganti ?? "-N/A-")
            }
            .store(in: &anyCancellable)
    }
    
}
