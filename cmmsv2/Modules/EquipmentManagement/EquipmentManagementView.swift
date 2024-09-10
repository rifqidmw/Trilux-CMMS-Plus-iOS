//
//  EquipmentManagementView.swift
//  cmmsv2
//
//  Created by macbook  on 10/09/24.
//

import UIKit

class EquipmentManagementView: BaseViewController {
    
    @IBOutlet weak var customNavigationView: CustomNavigationView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: EquipmentManagementPresenter?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
    }
    
}

extension EquipmentManagementView {
    
    private func setupBody() {
        setupView()
        setupAction()
    }
    
    private func setupView() {
        guard let presenter else { return }
        customNavigationView.configure(toolbarTitle: presenter.type == .returning ? "Pengembalian Alat" : "Peminjaman Alat", type: .plain)
        
        let segmentedItems: [EquipmentManagementSegmentedType]
        
        switch presenter.type {
        case .returning:
            segmentedItems = [.borrowed, .loan]
        case .loan:
            segmentedItems = [.submission, .request]
        }
        
        segmentedControl.removeAllSegments()
        
        for (index, item) in segmentedItems.enumerated() {
            segmentedControl.insertSegment(withTitle: item.getStringValue(), at: index, animated: false)
        }
        
        segmentedControl.selectedSegmentIndex = 0
    }
    
    private func setupAction() {
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        
        customNavigationView.arrowLeftBackButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let navigation = self.navigationController
                else { return }
                navigation.popViewController(animated: true)
            }
            .store(in: &anyCancellable)
    }
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        guard let selectedSegmentTitle = sender.titleForSegment(at: sender.selectedSegmentIndex) else { return }
        
        if let selectedType = EquipmentManagementSegmentedType(rawValue: selectedSegmentTitle) {
            print("Selected segment type: \(selectedType)")
        }
    }
}
