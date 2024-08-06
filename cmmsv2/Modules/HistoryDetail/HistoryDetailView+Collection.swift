//
//  HistoryDetailView+Collection.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 19/05/24.
//

import UIKit

extension HistoryDetailView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.damagedPictureCollectionView:
            return self.damagedMediaList.count
        case self.repairPictureCollectionView:
            return self.repairedMediaList.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case self.damagedPictureCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EvidenceEquipmentCVC.identifier, for: indexPath) as? EvidenceEquipmentCVC else {
                return UICollectionViewCell()
            }
            cell.setupCell(url: self.damagedMediaList[indexPath.row].valUrl ?? "")
            return cell
        case self.repairPictureCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EvidenceEquipmentCVC.identifier, for: indexPath) as? EvidenceEquipmentCVC else {
                return UICollectionViewCell()
            }
            cell.setupCell(url: self.repairedMediaList[indexPath.row].valUrl ?? "")
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        switch collectionView {
        case self.damagedPictureCollectionView:
            let selectedDamagedPicture = self.damagedMediaList[indexPath.row].valUrl ?? ""
            presenter.navigateToDetailDocument(navigation: navigation, file: selectedDamagedPicture)
        case self.repairPictureCollectionView:
            let selectedRepairPicture = self.repairedMediaList[indexPath.row].valUrl ?? ""
            presenter.navigateToDetailDocument(navigation: navigation, file: selectedRepairPicture)
        default: break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGSize.widthDevice / 3, height: collectionView.frame.height)
    }
    
}

extension HistoryDetailView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskItemTVC.identifier, for: indexPath) as? TaskItemTVC
        else {
            return UITableViewCell()
        }
        
        cell.setupCell(title: self.taskList[indexPath.row].txtName)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func calculateTotalHeight(for tableView: UITableView) -> CGFloat {
        var totalHeight: CGFloat = 0
        for row in 0..<tableView.numberOfRows(inSection: 0) {
            let indexPath = IndexPath(row: row, section: 0)
            totalHeight += tableView.rectForRow(at: indexPath).height
        }
        return totalHeight
    }
    
}
