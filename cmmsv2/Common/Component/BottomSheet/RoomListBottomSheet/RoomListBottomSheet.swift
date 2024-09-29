//
//  RoomListBottomSheet.swift
//  cmmsv2
//
//  Created by macbook  on 30/09/24.
//

import UIKit
import Combine

protocol RoomListBottomSheetDelegate: AnyObject {
    func didSelectRoom(_ room: AmprahRoomData, id: String)
}

class RoomListBottomSheet: BaseNonNavigationController {
    
    @IBOutlet weak var dismissAreaView: UIView!
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    @IBOutlet weak var containerTextFieldView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var id: String?
    var data: [AmprahRoomData] = []
    var filteredData: [AmprahRoomData] = []
    weak var delegate: RoomListBottomSheetDelegate?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.showBottomSheet()
        self.filteredData = self.data
    }
    
}

extension RoomListBottomSheet {
    
    private func setupBody() {
        setupView()
        setupAction()
        setupDelegate()
        setupTableView()
    }
    
    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(SelectionTVC.nib, forCellReuseIdentifier: SelectionTVC.identifier)
        self.tableView.separatorStyle = .none
    }
    
    private func setupView() {
        self.containerTextFieldView.makeCornerRadius(8)
    }
    
    private func setupAction() {
        Publishers.Merge(
            dismissAreaView.gesture(),
            bottomSheetView.handleBarArea.gesture())
        .sink { [weak self] _ in
            guard let self else { return }
            self.dismissBottomSheet()
        }
        .store(in: &anyCancellable)
    }
    
    private func setupDelegate() {
        self.textField.delegate = self
    }
    
}

extension RoomListBottomSheet: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectionTVC.identifier, for: indexPath) as? SelectionTVC
        else {
            return UITableViewCell()
        }
        
        cell.setupCell(title: self.filteredData[indexPath.row].text ?? "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let delegate, let id else { return }
        self.dismissBottomSheet() {
            delegate.didSelectRoom(self.filteredData[indexPath.row], id: id)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension RoomListBottomSheet: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if text.isEmpty {
            self.filteredData = self.data
        } else {
            self.filteredData = self.data.filter { $0.text?.lowercased().contains(text.lowercased()) ?? false }
        }
        self.tableView.reloadData()
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.filteredData = self.data
        self.tableView.reloadData()
        return true
    }
    
}
