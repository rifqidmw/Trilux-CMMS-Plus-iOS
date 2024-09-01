//
//  WorkLoadSectionView.swift
//  cmmsv2
//
//  Created by macbook  on 29/08/24.
//

import UIKit

class WorkLoadSectionView: UIView {
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var assetMedicTotalCardView: DashboardCardView!
    @IBOutlet weak var workLoadTotalCardView: DashboardCardView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        let view = loadNib()
        view.frame = self.bounds
        self.addSubview(view)
    }
    
}

extension WorkLoadSectionView {
    
    func configure(_ totalAsset: String, totalWorkLoad: String) {
        self.dateLabel.text = String.getCurrentDateString("MMMM yyyy")
        self.assetMedicTotalCardView.configure(image: "ic_target_rounded_fill", title: "Total Alat Medik", totalAsset)
        self.workLoadTotalCardView.configure(image: "ic_target_rounded_fill", title: "Total Beban Kerja Alat Medik", totalWorkLoad)
    }
    
}
