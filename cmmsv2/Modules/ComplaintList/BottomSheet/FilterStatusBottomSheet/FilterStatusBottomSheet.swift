//
//  FilterStatusBottomSheet.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 24/06/24.
//

import UIKit
import Combine

protocol FilterStatusBottomSheetDelegate: AnyObject {
    func didSelectStatusFilter(_ status: [StatusFilterEntity])
}

class FilterStatusBottomSheet: BaseNonNavigationController {
    
    @IBOutlet weak var dismissAreaView: UIView!
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var applyButton: GeneralButton!
    
    weak var delegate: FilterStatusBottomSheetDelegate?
    var selectedStatuses: Set<String> = []
    var data: [StatusFilterEntity] = [
        StatusFilterEntity(id: "0", status: .open),
        StatusFilterEntity(id: "1", status: .progress),
        StatusFilterEntity(id: "2", status: .closed),
    ]
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.showBottomSheet()
        self.selectedStatuses = Set(data.map { $0.id ?? "0"})
        self.collectionView.reloadData()
    }
    
}

extension FilterStatusBottomSheet {
    
    private func setupBody() {
        setupView()
        setupAction()
    }
    
    private func setupView() {
        applyButton.configure(title: "Terapkan")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(StatusFilterCell.nib, forCellWithReuseIdentifier: StatusFilterCell.identifier)
    }
    
    private func setupAction() {
        applyButton.gesture()
            .sink { [weak self] _ in
                guard let self, let delegate = self.delegate else { return }
                let selectedFilters = data.filter { self.selectedStatuses.contains($0.id ?? "0") }
                delegate.didSelectStatusFilter(selectedFilters)
                self.dismissBottomSheet()
            }
            .store(in: &anyCancellable)
        
        Publishers.Merge(bottomSheetView.handleBarArea.gesture(), dismissAreaView.gesture())
            .sink { [weak self] _ in
                guard let self else { return }
                self.dismissBottomSheet()
            }
            .store(in: &anyCancellable)
    }
    
}

extension FilterStatusBottomSheet: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StatusFilterCell.identifier, for: indexPath) as? StatusFilterCell
        else {
            return UICollectionViewCell()
        }
        
        let statusFilter = self.data[indexPath.row]
        let isSelected = selectedStatuses.contains(statusFilter.id ?? "0")
        cell.configure(title: statusFilter.status?.getStringValue() ?? "", isSelected: isSelected)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let statusFilter = self.data[indexPath.row]
        
        if selectedStatuses.contains(statusFilter.id ?? "0") {
            selectedStatuses.remove(statusFilter.id ?? "0")
        } else {
            selectedStatuses.insert(statusFilter.id ?? "0")
        }
        
        collectionView.reloadItems(at: [indexPath])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}
