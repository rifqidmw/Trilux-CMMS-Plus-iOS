//
//  AssetFilterView+TableView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 28/07/24.
//

import UIKit

extension AssetFilterView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.historyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchHistoryCell.identifier, for: indexPath) as? SearchHistoryCell
        else {
            return UITableViewCell()
        }
        
        let adjustedData = self.historyData[indexPath.row]
        cell.setupCell(title: adjustedData.title ?? "", idx: adjustedData.id, delegate: self)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItems = self.historyData[indexPath.row]
        guard let searchItem = selectedItems.title, let presenter else { return }
        self.selectedHistory = searchItem
        self.configureHistoryData()
        presenter.fetchInitData(search: searchItem)
        self.showLoadingPopup()
    }
    
}

extension AssetFilterView: SearchHistoryCellDelegate {
    
    func didDeleteSearchItem(idx: UUID) {
        AppManager.deleteSearchHistory(by: idx)
        self.configureHistoryData()
    }
    
}
