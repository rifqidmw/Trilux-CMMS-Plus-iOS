//
//  RepairSectionView.swift
//  cmmsv2
//
//  Created by macbook  on 29/08/24.
//

import UIKit

class RepairSectionView: UIView {
    
    @IBOutlet weak var titleSectionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var complaintInfoCardView: DashboardCardView!
    @IBOutlet weak var progressInfoCardView: DashboardCardView!
    @IBOutlet weak var doneInfoCardView: DashboardCardView!
    @IBOutlet weak var troubleInfoCardView: DashboardCardView!
    
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

extension RepairSectionView {
    
    func configure(_ data: MonthlyData?) {
        self.dateLabel.text = String.getCurrentDateString("MMMM yyyy")
        self.complaintInfoCardView.configure(image: "ic_document_arrow_rounded_fill", title: "Pengaduan", String(data?.open ?? 0))
        self.progressInfoCardView.configure(image: "ic_document_clock_rounded_fill", title: "Proses", String(data?.progress ?? 0))
        self.doneInfoCardView.configure(image: "ic_document_check_rounded_fill", title: "Selesai", String(data?.selesai ?? 0))
        self.troubleInfoCardView.configure(image: "ic_down_time_rounded_fill", title: "Kendala", String(data?.kendala ?? 0))
    }
    
}
