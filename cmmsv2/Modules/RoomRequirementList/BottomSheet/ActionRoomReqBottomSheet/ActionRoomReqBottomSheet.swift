//
//  ActionRoomReqBottomSheet.swift
//  cmmsv2
//
//  Created by macbook  on 06/10/24.
//

import UIKit
import Combine

protocol ActionRoomReqBottomSheetDelegate: AnyObject {
    func didTapProgress(_ data: RoomRequirementListData)
    func didTapDetail(_ data: RoomRequirementListData)
    func didTapUpdate(_ data: RoomRequirementListData)
    func didTapDelete(_ data: RoomRequirementListData)
}

class ActionRoomReqBottomSheet: BaseNonNavigationController {
    
    @IBOutlet weak var dismissAreaView: UIView!
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    @IBOutlet weak var deleteButton: GeneralButton!
    @IBOutlet weak var updateButton: GeneralButton!
    @IBOutlet weak var progressButton: GeneralButton!
    @IBOutlet weak var detailButton: GeneralButton!
    
    weak var delegate: ActionRoomReqBottomSheetDelegate?
    var type: RoomRequirementStatusType?
    var data: RoomRequirementListData?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.showBottomSheet()
    }
    
}

extension ActionRoomReqBottomSheet {
    
    private func setupBody() {
        setupView()
        setupAction()
    }
    
    private func setupView() {
        guard let type else { return }
        deleteButton.configure(title: "Hapus", backgroundColor: UIColor.customIndicatorColor3, titleColor: UIColor.customRedColor)
        updateButton.configure(title: "Update", backgroundColor: UIColor.customIndicatorColor2, titleColor: UIColor.customDarkYellowColor)
        progressButton.configure(title: "Progress", backgroundColor: UIColor.customLightGreenColor, titleColor: UIColor.customGreenColor)
        detailButton.configure(title: "Lihat")
        switch type {
        case .budgeting, .scoring:
            deleteButton.isHidden = true
            updateButton.isHidden = true
        case .submission:
            deleteButton.isHidden = false
            updateButton.isHidden = false
        default: break
        }
    }
    
    private func setupAction() {
        guard let delegate else { return }
        deleteButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let data = self.data
                else { return }
                self.dismissBottomSheet() {
                    delegate.didTapDelete(data)
                }
            }
            .store(in: &anyCancellable)
        
        updateButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let data = self.data
                else { return }
                self.dismissBottomSheet() {
                    delegate.didTapUpdate(data)
                }
            }
            .store(in: &anyCancellable)
        
        progressButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let data = self.data
                else { return }
                self.dismissBottomSheet() {
                    delegate.didTapProgress(data)
                }
            }
            .store(in: &anyCancellable)
        
        detailButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let data = self.data
                else { return }
                self.dismissBottomSheet() {
                    delegate.didTapDetail(data)
                }
            }
            .store(in: &anyCancellable)
        
        Publishers.Merge(dismissAreaView.gesture(), bottomSheetView.handleBarArea.gesture())
            .sink { [weak self] _ in
                guard let self else { return }
                self.dismissBottomSheet()
            }
            .store(in: &anyCancellable)
    }
    
}
