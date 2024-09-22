//
//  SelectComplaintActionBottomSheet.swift
//  cmmsv2
//
//  Created by macbook  on 21/09/24.
//

import UIKit
import Combine

enum SelectComplaintType {
    case detail
    case delegate
}

protocol SelectComplaintActionBottomSheetDelegate: AnyObject {
    func didTapDetailComplaint(_ id: String?)
    func didTapEditComplaint(_ id: String?, valType: String?)
    func didTapDeleteComplaint(_ id: String?)
    func didTapDetailComplaintDelegatable(_ id: String?)
}

class SelectComplaintActionBottomSheet: BaseNonNavigationController {
    
    @IBOutlet weak var dismissAreaView: UIView!
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    @IBOutlet weak var detailActionStackView: UIStackView!
    @IBOutlet weak var containerHelpBannerView: UIView!
    @IBOutlet weak var helpBannerTitleLabel: UILabel!
    @IBOutlet weak var helpBannerDescriptionLabel: UILabel!
    @IBOutlet weak var seeDetailComplaintView: GeneralButton!
    @IBOutlet weak var delegatableActionStackView: UIStackView!
    @IBOutlet weak var editComplaintButton: GeneralButton!
    @IBOutlet weak var deleteComplaintButton: GeneralButton!
    @IBOutlet weak var detailComplaintButton: GeneralButton!
    
    weak var delegate: SelectComplaintActionBottomSheetDelegate?
    var type: SelectComplaintType?
    var id: String?
    var valType: String?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.showBottomSheet()
    }
    
}

extension SelectComplaintActionBottomSheet {
    
    private func setupBody() {
        setupView()
        setupAction()
    }
    
    private func setupView() {
        seeDetailComplaintView.configure(title: "Lihat Pengaduan")
        editComplaintButton.configure(title: "Edit Pengaduan", type: .bordered)
        deleteComplaintButton.configure(title: "Hapus Pengaduan", backgroundColor: UIColor.customIndicatorColor3, titleColor: UIColor.customIndicatorColor4)
        detailComplaintButton.configure(title: "Lihat Pengaduan")
        containerHelpBannerView.makeCornerRadius(8)
        
        switch type {
        case .detail:
            self.detailActionStackView.isHidden = false
            self.delegatableActionStackView.isHidden = true
        case .delegate:
            self.detailActionStackView.isHidden = true
            self.delegatableActionStackView.isHidden = false
        default: break
        }
    }
    
    private func setupAction() {
        Publishers.Merge(seeDetailComplaintView.gesture(), detailComplaintButton.gesture())
            .sink { [weak self] _ in
                guard let self,
                      let delegate = self.delegate,
                      let id = self.id
                else { return }
                self.dismissBottomSheet() {
                    delegate.didTapDetailComplaint(id)
                }
            }
            .store(in: &anyCancellable)
        
        editComplaintButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let delegate = self.delegate,
                      let id = self.id,
                      let valType = self.valType
                else { return }
                self.dismissBottomSheet() {
                    delegate.didTapEditComplaint(id, valType: valType)
                }
            }
            .store(in: &anyCancellable)
        
        deleteComplaintButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let delegate = self.delegate,
                      let id = self.id
                else { return }
                self.dismissBottomSheet() {
                    delegate.didTapDeleteComplaint(id)
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
