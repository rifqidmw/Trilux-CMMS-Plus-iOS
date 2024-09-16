//
//  MutationBotomSheet.swift
//  cmmsv2
//
//  Created by macbook  on 14/09/24.
//

import UIKit
import Combine

class MutationBotomSheet: BaseNonNavigationController {
    
    @IBOutlet weak var dismissAreaView: UIView!
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var initialHeightTableViewConstraint: NSLayoutConstraint!
    
    weak var delegate: MutationBottomSheetDelegate?
    var data: [MenuModel] = mutationData
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.showBottomSheet()
    }
    
}

extension MutationBotomSheet {
    
    private func setupBody() {
        setupView()
        setupAction()
        setupTableView()
        calculateTotalHeight(for: self.tableView)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MenuItemTVC.nib, forCellReuseIdentifier: MenuItemTVC.identifier)
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
    }
    
    private func setupView() {
        bottomSheetView.configure(type: .withoutHandleBar)
    }
    
    private func setupAction() {
        Publishers.Merge(
            bottomSheetView.handleBarArea.gesture(),
            dismissAreaView.gesture())
        .sink { [weak self] _ in
            guard let self else { return }
            self.dismissBottomSheet()
        }
        .store(in: &anyCancellable)
        
    }
    
}

extension MutationBotomSheet: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuItemTVC.identifier, for: indexPath) as? MenuItemTVC
        else {
            return UITableViewCell()
        }
        
        cell.setupCell(data: data[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let delegate else { return }
        switch indexPath.row {
        case 0:
            self.dismissBottomSheet() {
                delegate.didTapAssetLoan()
            }
        case 1:
            self.dismissBottomSheet() {
                delegate.didTapAssetReturning()
            }
        case 2:
            self.dismissBottomSheet() {
                delegate.didTapMutation()
            }
        case 3:
            self.dismissBottomSheet() {
                delegate.didTapAmprah()
            }
        default: break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func calculateTotalHeight(for tableView: UITableView) {
        var totalHeight: CGFloat = 0
        for row in 0..<tableView.numberOfRows(inSection: 0) {
            let indexPath = IndexPath(row: row, section: 0)
            totalHeight += tableView.rectForRow(at: indexPath).height
        }
        self.initialHeightTableViewConstraint.constant = totalHeight
    }
    
}
