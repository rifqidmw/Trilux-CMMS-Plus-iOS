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
        case self.taskCollectionView:
            return self.taskList.count
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
        case self.taskCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TaskItemCVC.identifier, for: indexPath) as? TaskItemCVC else {
                return UICollectionViewCell()
            }
            cell.setupCell(self.taskList[indexPath.row].txtName ?? "")
            return cell
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
        let selectedDamagedPicture = self.damagedMediaList[indexPath.row].valUrl ?? ""
        
        let selectedRepairPicture = self.repairedMediaList[indexPath.row].valUrl ?? ""
        
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        switch collectionView {
        case self.taskCollectionView:
            break
        case self.damagedPictureCollectionView:
            presenter.navigateToDetailPicture(navigation: navigation, image: selectedDamagedPicture)
        case self.repairPictureCollectionView:
            presenter.navigateToDetailPicture(navigation: navigation, image: selectedRepairPicture)
        default: break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case self.taskCollectionView:
            return CGSize(width: collectionView.frame.width, height: 20)
        default: return CGSize(width: CGSize.widthDevice / 3, height: collectionView.frame.height)
        }
    }
    
}
