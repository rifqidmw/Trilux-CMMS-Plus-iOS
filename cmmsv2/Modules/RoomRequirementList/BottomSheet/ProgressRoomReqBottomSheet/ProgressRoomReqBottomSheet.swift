//
//  ProgressRoomReqBottomSheetViewController.swift
//  cmmsv2
//
//  Created by macbook  on 08/10/24.
//

import UIKit
import Combine

class ProgressRoomReqBottomSheet: BaseNonNavigationController {
    
    @IBOutlet weak var dismissAreaView: UIView!
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    @IBOutlet weak var closeButton: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var initialHeightConstraint: NSLayoutConstraint!
    
    var data: [Progress] = []
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.showBottomSheet()
    }
    
}

extension ProgressRoomReqBottomSheet {
    
    private func setupBody() {
        setupView()
        setupAction()
    }
    
    private func setupView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProgressRoomCell.nib, forCellReuseIdentifier: ProgressRoomCell.identifier)
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        calculateTotalHeight(for: self.tableView)
    }
    
    private func setupAction() {
        Publishers.Merge3(
            dismissAreaView.gesture(),
            bottomSheetView.handleBarArea.gesture(),
            closeButton.gesture())
        .sink { [weak self] _ in
            guard let self else { return }
            self.dismissBottomSheet()
        }
        .store(in: &anyCancellable)
    }
    
}

extension ProgressRoomReqBottomSheet: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProgressRoomCell.identifier, for: indexPath) as? ProgressRoomCell
        else {
            return UITableViewCell()
        }
        
        let progressItem = data.reversed()[indexPath.row]
        let isComplete = progressItem.stt == "1"
        cell.setupCell(title: progressItem.text, description: progressItem.info, isComplete: isComplete)
        
        return cell
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
        initialHeightConstraint.constant = totalHeight
    }
    
}
