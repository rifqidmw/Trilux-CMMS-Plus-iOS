//
//  StatusSection.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 11/07/24.
//

import UIKit
import Combine

protocol StatusSectionDelegate: AnyObject {
    func didTapSelectStatus()
    func didTapSelectFinishStatus()
}

class StatusSection: UIView {
    
    @IBOutlet weak var selectStatusView: SelectView!
    @IBOutlet weak var selectFinishStatusView: SelectView!
    
    var statusData: WorkingStatusEntity? {
        didSet {
            configureSharedComponent()
        }
    }
    var finishStatusData: WorkingFinishStatusEntity? {
        didSet {
            configureSharedComponent()
        }
    }
    var anyCancellable = Set<AnyCancellable>()
    weak var delegate: StatusSectionDelegate?
    
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
        self.setupBody()
    }
    
}

extension StatusSection {
    
    private func setupBody() {
        self.configureSharedComponent()
        self.setupAction()
    }
    
    private func configureSharedComponent() {
        guard let statusData = self.statusData else {
            self.selectFinishStatusView.isHidden = true
            self.selectStatusView.configure(title: "Status", placeHolder: "Pilih Status", value: nil)
            return
        }
        
        self.selectStatusView.configure(title: "Status", placeHolder: "Pilih Status", value: statusData.label)
        
        if statusData.lkStatus == "3" {
            self.selectFinishStatusView.isHidden = false
            if let finishStatusData = self.finishStatusData {
                self.selectFinishStatusView.configure(title: "Finish Status", placeHolder: "Pilih Finish Status", value: finishStatusData.label)
            } else {
                self.selectFinishStatusView.configure(title: "Finish Status", placeHolder: "Pilih Finish Status", value: nil)
            }
        } else {
            self.selectFinishStatusView.isHidden = true
        }
    }
    
    private func setupAction() {
        selectStatusView.gesture()
            .sink { [weak self] _ in
                guard let self, let delegate = self.delegate else { return }
                delegate.didTapSelectStatus()
            }
            .store(in: &anyCancellable)
        
        selectFinishStatusView.gesture()
            .sink { [weak self] _ in
                guard let self, let delegate = self.delegate else { return }
                delegate.didTapSelectFinishStatus()
            }
            .store(in: &anyCancellable)
    }
    
}
