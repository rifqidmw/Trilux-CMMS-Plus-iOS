//
//  WorkSheetDetailView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 21/01/24.
//

import UIKit

class WorkSheetMonitoringFunctionDetailView: BaseViewController {
    
    @IBOutlet weak var navigationView: CustomNavigationView!
    @IBOutlet weak var imageCardView: ImageCardSectionView!
    @IBOutlet weak var detailComplaintView: DetailComplaintSectionView!
    @IBOutlet weak var workStartContainerView: UIView!
    @IBOutlet weak var workStartDateTimeLabel: UILabel!
    @IBOutlet weak var workButton: GeneralButton!
    @IBOutlet weak var resumeWorkButton: GeneralButton!
    @IBOutlet weak var seeWorkButton: GeneralButton!
    
    var presenter: WorkSheetMonitoringFunctionDetailPresenter?
    var header: WorkSheetCardEntity = dummyImageCardData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBody()
    }
    
}

extension WorkSheetMonitoringFunctionDetailView {
    
    private func setupBody() {
        setupView()
        setupAction()
    }
    
    private func setupView() {
        navigationView.configure(plainTitle: "Lembar Kerja", type: .plain)
        imageCardView.configure(data: header)
        detailComplaintView.configure(
            topics: "Lampunya Mati",
            chronology: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            date: "22-Nov-2021",
            time: "07:01 AM",
            status: "Anda Sebagai Pendamping")
        detailComplaintView.delegate = self
        workStartContainerView.makeCornerRadius(8)
        workStartDateTimeLabel.text = "19 November 2022 - 17:00 WIB"
        workButton.configure(title: "Kerjakan", type: .borderedWithIcon, icon: "ic_scan_gray", titleColor: UIColor.customPlaceholderColor)
        resumeWorkButton.configure(title: "Lanjutkan Pekerjaan", type: .normal, backgroundColor: UIColor.customLightYellowColor, titleColor: UIColor.customDarkYellowColor)
        seeWorkButton.configure(title: "Lihat Pekerjaan", type: .normal, backgroundColor: UIColor.customLightGreenColor, titleColor: UIColor.customGreenColor)
    }
    
    private func setupAction() {
        navigationView.arrowLeftBackButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let navigation = self.navigationController
                else { return }
                navigation.popViewController(animated: true)
            }
            .store(in: &anyCancellable)
    }
    
}

extension WorkSheetMonitoringFunctionDetailView: WorkSheetDetailDelegate {
    
    func didTapSeeAllEvidence() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        self.showOverlay()
        presenter.showBottomSheetAllEvidence(navigation: navigation)
    }
    
    func didTapImage(titlePage: String, image: String) {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToFullScreenPicture(navigation: navigation, titlePage: titlePage, image: image)
    }
    
}
