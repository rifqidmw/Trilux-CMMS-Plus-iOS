//
//  WorkSheetOnsitePreventiveDetailView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/02/24.
//

import UIKit
import SkeletonView

class WorkSheetDetailView: BaseViewController {
    
    @IBOutlet weak var navigationView: CustomNavigationView!
    @IBOutlet weak var assetSectionView: AssetSectionView!
    @IBOutlet weak var assetSectionHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var preparationSectionView: AccordionView!
    @IBOutlet weak var preparationSectionHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var calibrationMeasurementSectionView: AccordionView!
    @IBOutlet weak var calibrationSectionHeightConstraint: NSLayoutConstraint!
    
    var preparationView = PreparationSectionView()
    var calibrationView = CalibrationSectionView()
    var presenter: WorkSheetDetailPresenter?
    
    override func didLoad() {
        super.didLoad()
        setupBody()
    }
    
}

extension WorkSheetDetailView {
    
    private func setupBody() {
        showAnimationSkeleton()
        fetchInitialData()
        bindingHeight()
        bindingData()
        setupView()
        setupAction()
    }
    
    private func setupView() {
        navigationView.configure(plainTitle: "Detail Lembar Kerja", type: .plain)
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
    
    private func fetchInitialData() {
        guard let presenter else { return }
        presenter.fetchInitialData()
    }
    
    private func bindingData() {
        guard let presenter else { return }
        presenter.$monitoringFunctionData
            .sink { [weak self ] data in
                guard let self,
                      let data,
                      let detail = data.data,
                      let reff = data.reff,
                      let preparation = detail.persiapan,
                      let calibration = detail.alatKalibrasi
                else { return }
                self.hideAnimationSkeleton()
                
                self.assetSectionView.configure(data: detail, reff: reff)
                self.assetSectionHeightConstraint.constant = self.assetSectionView.initialContentHeightConstraint.constant
                self.assetSectionView.layoutIfNeeded()
                
                self.preparationView.configure(data: preparation)
                self.preparationSectionView.configure(title: "Persiapan", icon: "ic_sheet_check", view: preparationView)
                
                self.calibrationView.configure(data: calibration)
                self.calibrationMeasurementSectionView.configure(title: "Pengukuran Kalibrasi", icon: "ic_infinity", view: calibrationView)
                
                self.preparationSectionView.isHidden = preparation.isEmpty
                self.calibrationMeasurementSectionView.isHidden = calibration.isEmpty
            }
            .store(in: &anyCancellable)
    }
    
    private func bindingHeight() {
        preparationSectionView.$totalHeightTable
            .receive(on: DispatchQueue.main)
            .sink { [weak self] height in
                guard let self else { return }
                self.preparationSectionHeightConstraint.constant = height
                self.preparationSectionView.layoutIfNeeded()
            }
            .store(in: &anyCancellable)
        
        calibrationMeasurementSectionView.$totalHeightTable
            .receive(on: DispatchQueue.main)
            .sink { [weak self] height in
                guard let self else { return }
                self.calibrationSectionHeightConstraint.constant = height
                self.calibrationMeasurementSectionView.layoutIfNeeded()
            }
            .store(in: &anyCancellable)
    }
    
}

extension WorkSheetDetailView {
    
    private func showAnimationSkeleton() {
        [self.preparationSectionView,
         self.calibrationMeasurementSectionView].forEach {
            $0.isSkeletonable = true
            $0.showAnimatedGradientSkeleton()
        }
    }
    
    private func hideAnimationSkeleton() {
        [self.preparationSectionView,
         self.calibrationMeasurementSectionView].forEach {
            $0.hideSkeleton()
        }
    }
    
}
