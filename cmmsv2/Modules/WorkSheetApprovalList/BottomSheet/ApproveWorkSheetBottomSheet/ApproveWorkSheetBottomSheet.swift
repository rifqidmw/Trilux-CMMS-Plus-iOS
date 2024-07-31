//
//  ApproveWorkSheetBottomSheet.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 30/07/24.
//

import UIKit
import Combine

protocol ApproveWorkSheetBottomSheetDelegate: AnyObject {
    func didTapDetail(id: String)
    func didTapApprove(woId: String, status: String)
}

class ApproveWorkSheetBottomSheet: BaseNonNavigationController {
    
    @IBOutlet weak var dismissAreaView: UIView!
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var workSheetNumberView: InformationCardView!
    @IBOutlet weak var assetView: InformationCardView!
    @IBOutlet weak var startTimeView: InformationCardView!
    @IBOutlet weak var endTimeView: InformationCardView!
    @IBOutlet weak var workingDurationView: InformationCardView!
    @IBOutlet weak var detailButton: GeneralButton!
    @IBOutlet weak var approveButton: GeneralButton!
    
    weak var delegate: ApproveWorkSheetBottomSheetDelegate?
    var data: WorkSheetApproval?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.showBottomSheet()
    }
    
}

extension ApproveWorkSheetBottomSheet {
    
    private func setupBody() {
        setupView()
        setupAction()
    }
    
    private func setupView() {
        guard let data else { return }
        detailButton.configure(title: "Rincian", type: .bordered)
        approveButton.configure(title: "Setujui")
        titleLabel.text = "Response Time: \(data.complain?.txtResponseTime ?? "-")"
        workSheetNumberView.configureView(title: "No. Lembar Kerja", value: data.valWoNumber ?? "-")
        assetView.configureView(title: "Nama Alat", value: data.txtTitle ?? "-")
        startTimeView.configureView(title: "Mulai Bekerja", value: data.valStartTime ?? "-")
        endTimeView.configureView(title: "Selesai Bekerja", value: data.valEndTime ?? "-")
        workingDurationView.configureView(title: "Durasi Bekerja", value: data.valDuration ?? "-")
    }
    
    private func setupAction() {
        guard let delegate else { return }
        Publishers.Merge(
            dismissAreaView.gesture(),
            bottomSheetView.handleBarArea.gesture())
        .sink { [weak self] _ in
            guard let self else { return }
            self.dismissBottomSheet()
        }
        .store(in: &anyCancellable)
        
        detailButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let data,
                      let id = data.id else { return }
                self.dismissBottomSheet() {
                    delegate.didTapDetail(id: String(id))
                }
            }
            .store(in: &anyCancellable)
        
        approveButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let data,
                      let woId = data.id,
                      let status = data.stt_qr else { return }
                self.dismissBottomSheet() {
                    delegate.didTapApprove(woId: String(woId), status: String(status))
                }
            }
            .store(in: &anyCancellable)
    }
    
}
