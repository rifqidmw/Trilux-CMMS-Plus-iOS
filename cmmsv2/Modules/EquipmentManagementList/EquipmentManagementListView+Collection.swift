//
//  EquipmentManagementListView+TableView.swift
//  cmmsv2
//
//  Created by macbook  on 18/09/24.
//

import UIKit
import SkeletonView

extension EquipmentManagementListView: SkeletonTableViewDataSource, SkeletonTableViewDelegate, UIScrollViewDelegate {
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return EquipmentManagementCell.identifier
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch presenter?.type {
        case .loan:
            if segmentedControl.selectedSegmentIndex == 0 {
                return self.submissionData.count
            } else {
                return self.requestData.count
            }
        case .returning:
            if segmentedControl.selectedSegmentIndex == 0 {
                return self.loanData.count
            } else {
                return self.borrowedData.count
            }
        case .mutation:
            if segmentedControl.selectedSegmentIndex == 0 {
                return self.mutationSubmissionData.count
            } else {
                return self.mutationRequestData.count
            }
        default: break
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EquipmentManagementCell.identifier, for: indexPath) as? EquipmentManagementCell,
              let presenter
        else {
            return UITableViewCell()
        }
        
        switch presenter.type {
        case .loan:
            if segmentedControl.selectedSegmentIndex == 0 {
                let adjustedData = self.submissionData[indexPath.row]
                let installationTitle = NSAttributedString.stylizedText("Instalasi Tujuan: ", font: UIFont.robotoRegular(10), color: UIColor.customPlaceholderColor)
                let installation = NSAttributedString.stylizedText(adjustedData.tujuanName ?? "-", font: UIFont.robotoBold(12), color: UIColor.customPrimaryColor)
                
                let fullInstallationTitle = NSMutableAttributedString()
                fullInstallationTitle.append(installationTitle)
                fullInstallationTitle.append(installation)
                
                let assetCountTitle = NSAttributedString.stylizedText("Jumlah Alat: ", font: UIFont.robotoRegular(10), color: UIColor.customPlaceholderColor)
                let assetCount = NSAttributedString.stylizedText(adjustedData.qtyApprove ?? "-", font: UIFont.robotoBold(12), color: UIColor.customPrimaryColor)
                
                let fullAssetCountTitle = NSMutableAttributedString()
                fullAssetCountTitle.append(assetCountTitle)
                fullAssetCountTitle.append(assetCount)
                
                cell.setupCell(
                    destination: fullInstallationTitle,
                    date: adjustedData.createdAt ?? "-",
                    title: adjustedData.alatName ?? "-",
                    description: adjustedData.instalasiName ?? "-",
                    assetCount: fullAssetCountTitle,
                    status: adjustedData.statusText ?? "-")
                
            } else {
                let adjustedData = self.requestData[indexPath.row]
                let destinationInstallationTitle = NSAttributedString.stylizedText("Instalasi Tujuan: ", font: UIFont.robotoRegular(10), color: UIColor.customPlaceholderColor)
                let destinationInstallation = NSAttributedString.stylizedText(adjustedData.fromInstalasiText ?? "-", font: UIFont.robotoBold(12), color: UIColor.customPrimaryColor)
                
                let fullInstallationTitle = NSMutableAttributedString()
                fullInstallationTitle.append(destinationInstallationTitle)
                fullInstallationTitle.append(destinationInstallation)
                
                let destinationTitle = NSAttributedString.stylizedText("Tujuan: ", font: UIFont.robotoRegular(10), color: UIColor.customPlaceholderColor)
                let destination = NSAttributedString.stylizedText(adjustedData.toRoomText ?? "-", font: UIFont.robotoBold(12), color: UIColor.customPrimaryColor)
                
                let fullDestinationText = NSMutableAttributedString()
                fullDestinationText.append(destinationTitle)
                fullDestinationText.append(destination)
                
                cell.setupCell(
                    destination: fullInstallationTitle,
                    date: adjustedData.serial ?? "-",
                    title: adjustedData.assetName ?? "-",
                    description: adjustedData.toInstalasiText ?? "-",
                    assetCount: fullDestinationText,
                    status: adjustedData.statusText ?? "-")
            }
        case .returning:
            if segmentedControl.selectedSegmentIndex == 0 {
                let adjustedData = self.loanData[indexPath.row]
                
                let destinationInstallation = NSAttributedString.stylizedText(adjustedData.fromInstalasiText ?? "-", font: UIFont.robotoBold(12), color: UIColor.customPrimaryColor)
                
                let serialNumberTitle = NSAttributedString.stylizedText("Serial Number: ", font: UIFont.robotoRegular(10), color: UIColor.customPlaceholderColor)
                let serialNumber = NSAttributedString.stylizedText(adjustedData.serial ?? "-", font: UIFont.robotoBold(12), color: UIColor.customPrimaryColor)
                
                let fullSerialNumberText = NSMutableAttributedString()
                fullSerialNumberText.append(serialNumberTitle)
                fullSerialNumberText.append(serialNumber)
                
                cell.setupCell(
                    destination: destinationInstallation,
                    date: adjustedData.serial ?? "-",
                    title: adjustedData.assetName ?? "-",
                    description: adjustedData.toInstalasiText ?? "-",
                    assetCount: fullSerialNumberText)
            } else {
                let adjustedData = self.borrowedData[indexPath.row]
                
                let destinationInstallation = NSAttributedString.stylizedText(adjustedData.fromInstalasiText ?? "-", font: UIFont.robotoBold(12), color: UIColor.customPrimaryColor)
                
                let serialNumberTitle = NSAttributedString.stylizedText("Tujuan: ", font: UIFont.robotoRegular(10), color: UIColor.customPlaceholderColor)
                let serialNumber = NSAttributedString.stylizedText(adjustedData.toRoomText ?? "-", font: UIFont.robotoBold(12), color: UIColor.customPrimaryColor)
                
                let fullSerialNumberText = NSMutableAttributedString()
                fullSerialNumberText.append(serialNumberTitle)
                fullSerialNumberText.append(serialNumber)
                
                cell.setupCell(
                    destination: destinationInstallation,
                    date: adjustedData.serial ?? "-",
                    title: adjustedData.assetName ?? "-",
                    description: adjustedData.toInstalasiText ?? "-",
                    assetCount: fullSerialNumberText)
            }
        case .mutation:
            if segmentedControl.selectedSegmentIndex == 0 {
                let adjustedData = self.mutationSubmissionData[indexPath.row]
                let installationTitle = NSAttributedString.stylizedText("Instalasi Tujuan: ", font: UIFont.robotoRegular(10), color: UIColor.customPlaceholderColor)
                let installation = NSAttributedString.stylizedText(adjustedData.tujuanName ?? "-", font: UIFont.robotoBold(12), color: UIColor.customPrimaryColor)
                
                let fullInstallationTitle = NSMutableAttributedString()
                fullInstallationTitle.append(installationTitle)
                fullInstallationTitle.append(installation)
                
                let assetCountTitle = NSAttributedString.stylizedText("Jumlah Alat: ", font: UIFont.robotoRegular(10), color: UIColor.customPlaceholderColor)
                let assetCount = NSAttributedString.stylizedText(adjustedData.qtyApprove ?? "-", font: UIFont.robotoBold(12), color: UIColor.customPrimaryColor)
                
                let fullAssetCountTitle = NSMutableAttributedString()
                fullAssetCountTitle.append(assetCountTitle)
                fullAssetCountTitle.append(assetCount)
                
                cell.setupCell(
                    destination: fullInstallationTitle,
                    date: adjustedData.createdAt ?? "-",
                    title: adjustedData.alatName ?? "-",
                    description: adjustedData.instalasiName ?? "-",
                    assetCount: fullAssetCountTitle,
                    status: adjustedData.statusText ?? "-")
                
            } else {
                let adjustedData = self.mutationRequestData[indexPath.row]
                let destinationInstallationTitle = NSAttributedString.stylizedText("Instalasi Tujuan: ", font: UIFont.robotoRegular(10), color: UIColor.customPlaceholderColor)
                let destinationInstallation = NSAttributedString.stylizedText(adjustedData.tujuanName ?? "-", font: UIFont.robotoBold(12), color: UIColor.customPrimaryColor)
                
                let fullInstallationTitle = NSMutableAttributedString()
                fullInstallationTitle.append(destinationInstallationTitle)
                fullInstallationTitle.append(destinationInstallation)
                
                let assetCountTitle = NSAttributedString.stylizedText("Jumlah Alat: ", font: UIFont.robotoRegular(10), color: UIColor.customPlaceholderColor)
                let assetCount = NSAttributedString.stylizedText(adjustedData.qty ?? "-", font: UIFont.robotoBold(12), color: UIColor.customPrimaryColor)
                
                let fullAssetCountText = NSMutableAttributedString()
                fullAssetCountText.append(assetCountTitle)
                fullAssetCountText.append(assetCount)
                
                cell.setupCell(
                    destination: fullInstallationTitle,
                    date: adjustedData.createdAt ?? "-",
                    title: adjustedData.alatName ?? "-",
                    description: adjustedData.instalasiName ?? "-",
                    assetCount: fullAssetCountText,
                    status: adjustedData.statusText ?? "-")
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        switch presenter.type {
        case .loan:
            if segmentedControl.selectedSegmentIndex == 0 {
                presenter.navigateToEquipmentManagementDetail(from: navigation, self.submissionData[indexPath.row].idRl ?? "", type: .loan)
            } else {
                presenter.showApproveConfirmationPopUp(from: navigation, id: self.requestData[indexPath.row].idRl ?? "", self)
            }
        case .returning:
            if segmentedControl.selectedSegmentIndex == 0 {
                AppLogger.log("-- GO TO DETAIL PENGEMBALIAN")
            } else {
                AppLogger.log("-- GO TO DETAIL PENGEMBALIAN")
            }
        case .mutation:
            if segmentedControl.selectedSegmentIndex == 0 {
                presenter.navigateToEquipmentManagementDetail(from: navigation, self.mutationSubmissionData[indexPath.row].idMT ?? "", type: .mutation)
            } else {
                presenter.navigateToEquipmentManagementDetail(from: navigation, self.mutationRequestData[indexPath.row].idMT ?? "", type: .mutation)
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard scrollView == scrollView,
              let presenter = self.presenter
        else { return }
        
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if presenter.type == .returning {
            if maximumOffset - currentOffset <= 0.0 && presenter.isCanLoad {
                self.showSpinner(true)
                
                DispatchQueue.main.async {
                    presenter.fetchNextPage()
                }
            }
        }
    }
    
}
