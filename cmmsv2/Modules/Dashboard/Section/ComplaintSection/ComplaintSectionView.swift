//
//  ComplaintSectionView.swift
//  cmmsv2
//
//  Created by macbook  on 29/08/24.
//

import UIKit

class ComplaintSectionView: UIView {
    
    @IBOutlet weak var titleSectionLabel: UILabel!
    @IBOutlet weak var complaintInfoCardView: DashboardCardView!
    @IBOutlet weak var openInfoCardView: DashboardCardView!
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
        self.configureView()
    }
    
}

extension ComplaintSectionView {
    
    private func setupBody() {
        configureView()
        setupAction()
    }
    
    private func configureView() {
        self.complaintInfoCardView.configure(image: "ic_document_arrow_rounded_fill", title: "Pengaduan", "-")
        self.openInfoCardView.configure(image: "ic_document_pencil_rounded_fill", title: "Open", "-")
        self.progressInfoCardView.configure(image: "ic_document_clock_rounded_fill", title: "Proses", "-")
        self.doneInfoCardView.configure(image: "ic_document_check_rounded_fill", title: "Selesai", "-")
        self.troubleInfoCardView.configure(image: "ic_down_time_rounded_fill", title: "Kendala", "-")
    }
    
    private func setupAction() {
        
    }
    
}
