//
//  SelectStatusBottomSheet.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 11/07/24.
//

import UIKit
import Combine

struct WorkingStatusEntity: Codable {
    var id: String?
    var lkStatus: String?
    var label: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case lkStatus = "lk_status"
        case label
    }
}

struct WorkingFinishStatusEntity: Codable {
    var id: String?
    var lkFinishstt: String?
    var label: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case lkFinishstt = "lk_finishstt"
        case label
    }
}

enum SelectStatusType {
    case normal
    case finish
}

protocol SelectStatusBottomSheetDelegate: AnyObject {
    func didSelectStatus(_ status: WorkingStatusEntity)
    func didSelectFinishStatus(_ finishStt: WorkingFinishStatusEntity)
}

class SelectStatusBottomSheet: BaseNonNavigationController {
    
    @IBOutlet weak var dismissAreaView: UIView!
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var type: SelectStatusType?
    var statusData: [WorkingStatusEntity] = []
    var finishStatusData: [WorkingFinishStatusEntity] = []
    weak var delegate: SelectStatusBottomSheetDelegate?
    
    override func didLoad() {
        super.didLoad()
        self.showBottomSheet()
        self.setupBody()
    }
    
}

extension SelectStatusBottomSheet {
    
    private func setupBody() {
        setupAction()
        setupTableView()
    }
    
    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(SelectionTVC.nib, forCellReuseIdentifier: SelectionTVC.identifier)
        self.tableView.separatorStyle = .none
    }
    
    private func setupAction() {
        Publishers.Merge(dismissAreaView.gesture(),
                         bottomSheetView.handleBarArea.gesture())
        .sink { [weak self] _ in
            guard let self else { return }
            self.dismissBottomSheet()
        }
        .store(in: &anyCancellable)
    }
    
}

extension SelectStatusBottomSheet: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.type == .normal {
            return self.statusData.count
        } else {
            return self.finishStatusData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectionTVC.identifier, for: indexPath) as? SelectionTVC
        else {
            return UITableViewCell()
        }
        
        if self.type == .normal {
            cell.setupCell(title: self.statusData[indexPath.row].label ?? "")
        } else {
            cell.setupCell(title: self.finishStatusData[indexPath.row].label ?? "")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let delegate else { return }
        self.dismissBottomSheet() {
            if self.type == .normal {
                delegate.didSelectStatus(self.statusData[indexPath.row])
            } else {
                delegate.didSelectFinishStatus(self.finishStatusData[indexPath.row])
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
