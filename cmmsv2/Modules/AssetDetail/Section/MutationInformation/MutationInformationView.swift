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
    
    override func didLoad() {
        super.didLoad()
        self.setupView()
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
    
    private func setupView() {
        roomInfoView.configure(type: .withDesc, infoTitle: "Ruangan", icon: "ic_user_rounded_square", detailInfoTitle: "Ruangan Bedah", detailInfoDesc: "Jenis Pelayanan")
        acceptanceInfoView.configureView(title: "Data Penerimaan", value: "-N/A-")
        mutationToolsInfoView.configureView(title: "Mutasi Alat", value: "-N/A-")
        deletionInfoView.configureView(title: "Penghapusan", value: "-N/A-")
    }
    
}
