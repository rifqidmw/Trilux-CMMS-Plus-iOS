//
//  SelectTechnicianBottomSheet.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 14/06/24.
//

import UIKit
import Combine

enum SelectTechnicianBottomSheetType {
    case selectOne
    case selectMultiple
}

class SelectTechnicianBottomSheet: BaseNonNavigationController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dismissAreaView: UIView!
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    @IBOutlet weak var selectAllButton: UILabel!
    @IBOutlet weak var containerTextFieldView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var type: SelectTechnicianBottomSheetType?
    var data: [TechnicianData] = []
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
    }
    
}

extension SelectTechnicianBottomSheet {
    
    private func setupBody() {
        setupView()
        setupAction()
        setupTableView()
    }
    
    private func setupView() {
        bottomSheetView.configure(type: .withoutHandleBar)
        containerTextFieldView.makeCornerRadius(8)
        
        switch self.type {
        case .selectOne:
            textField.placeholder = "Cari Teknisi yang diinginkan"
            titleLabel.text = "Pilih Teknisi"
        case .selectMultiple:
            textField.placeholder = "Cari Pendamping yang diinginkan"
            titleLabel.text = "Pilih Pendamping"
            selectAllButton.isHidden = true
        default: break
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            UIView.animate(withDuration: 0.2, animations: {
                self.dismissAreaView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            })
        }
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SelectTechnicialCell.nib, forCellReuseIdentifier: SelectTechnicialCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
    }
    
    private func setupAction() {
        Publishers.Merge(bottomSheetView.handleBarArea.gesture(), dismissAreaView.gesture())
            .sink { [weak self] _ in
                guard let self else { return }
                self.dismissBottomSheet()
            }
            .store(in: &anyCancellable)
    }
    
    private func dismissBottomSheet() {
        UIView.animate(withDuration: 0.2, animations: {
            self.dismissAreaView.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        }) { _ in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}

extension SelectTechnicianBottomSheet: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectTechnicialCell.identifier, for: indexPath) as? SelectTechnicialCell,
              let technicianName = self.data[indexPath.row].txtName,
              let type
        else {
            return UITableViewCell()
        }
        
        cell.setupCell(name: technicianName, type: type)
        
        return cell
    }
    
}
