//
//  FilterStatusBottomSheet.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 24/06/24.
//

import UIKit
import Combine

enum FilterStatusBottomSheetType {
    case multiple
    case single
}

protocol FilterStatusBottomSheetDelegate: AnyObject {
    func didSelectStatusFilter(_ multiple: [StatusFilterEntity], single: StatusFilterEntity)
}

class FilterStatusBottomSheet: BaseNonNavigationController {
    
    @IBOutlet weak var dismissAreaView: UIView!
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var applyButton: GeneralButton!
    @IBOutlet weak var initialHeightCollectionView: NSLayoutConstraint!
    
    weak var delegate: FilterStatusBottomSheetDelegate?
    var selectedStatuses: Set<String> = []
    var data: [StatusFilterEntity] = []
    var selectedIndex: IndexPath?
    var selectedStatus: StatusFilterEntity?
    var type: FilterStatusBottomSheetType = .multiple
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.showBottomSheet()
        self.selectedStatuses = Set(data.map { $0.id ?? "0"})
        self.collectionView.reloadData()
        self.initialHeightCollectionView.constant = 200 + self.calculateCollectionView(self.data)
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
        
        let layout = LeftAlignedCollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        
        if type == .single {
            if !data.isEmpty {
                selectedIndex = IndexPath(row: 0, section: 0)
                selectedStatus = data[0]
            }
        }
    }
    
    private func setupAction() {
        applyButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let delegate = self.delegate,
                      let selectedStatus
                else { return }
                let selectedFilters = data.filter { self.selectedStatuses.contains($0.id ?? "0") }
                self.dismissBottomSheet() {
                    delegate.didSelectStatusFilter(selectedFilters, single: selectedStatus)
                }
            }
            .store(in: &anyCancellable)
        
        Publishers.Merge(bottomSheetView.handleBarArea.gesture(), dismissAreaView.gesture())
            .sink { [weak self] _ in
                guard let self else { return }
                self.dismissBottomSheet()
            }
            .store(in: &anyCancellable)
    }
    
    private func calculateCollectionView(_ data: [StatusFilterEntity]) -> CGFloat {
        let initialHeight: CGFloat = 30
        let totalHeight = (CGFloat(data.count) * initialHeight) / 4
        return totalHeight
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
        
        if type == .multiple {
            let statusFilter = self.data[indexPath.row]
            let isSelected = selectedStatuses.contains(statusFilter.id ?? "0")
            cell.configure(title: statusFilter.status?.getStringValue() ?? "", isSelected: isSelected)
        } else {
            let sortEntity = data[indexPath.row]
            let isSelected = indexPath == selectedIndex
            cell.configure(title: sortEntity.status?.getStringValue() ?? "", isSelected: isSelected)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let statusFilter = self.data[indexPath.row]
        
        switch type {
        case .multiple:
            if selectedStatuses.contains(statusFilter.id ?? "0") {
                selectedStatuses.remove(statusFilter.id ?? "0")
            } else {
                selectedStatuses.insert(statusFilter.id ?? "0")
            }
        case .single:
            if let selectedIndex = selectedIndex {
                collectionView.deselectItem(at: selectedIndex, animated: true)
                let previousCell = collectionView.cellForItem(at: selectedIndex) as? StatusFilterCell
                previousCell?.configure(title: data[selectedIndex.row].status?.getStringValue() ?? "", isSelected: false)
            }
            
            selectedIndex = indexPath
            selectedStatus = data[indexPath.row]
            
            let cell = collectionView.cellForItem(at: indexPath) as? StatusFilterCell
            cell?.configure(title: data[indexPath.row].status?.getStringValue() ?? "", isSelected: true)
        }
        
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = self.data[indexPath.row].status?.getStringValue()
        let width = UILabel().textWidth(
            font: UIFont.robotoRegular(12),
            text: text ?? "")
        return CGSize(width: width + 32, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}
