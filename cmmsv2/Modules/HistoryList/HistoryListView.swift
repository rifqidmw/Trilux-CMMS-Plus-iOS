//
//  HistoryListView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/03/24.
//

import UIKit

class HistoryListView: BaseViewController {
    
    @IBOutlet weak var customNavigationView: CustomNavigationView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var actionBarView: ActionBarView!
    
    var presenter: HistoryListPresenter?
    var data: [HistoryListEntity] = historyDataList
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
    }
    
}

extension HistoryListView {
    
    private func setupBody() {
        setupView()
        setupAction()
        setupTableView()
    }
    
    private func setupView() {
        customNavigationView.configure(plainTitle: "Riwayat Pengaduan", type: .plain)
        actionBarView.configure(fourthIcon: "ic_setting", fourthTitle: "Kondisi")
    }
    
    private func setupAction() {
        customNavigationView.arrowLeftBackButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let navigation = self.navigationController
                else { return }
                navigation.popViewController(animated: true)
            }
            .store(in: &anyCancellable)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HistoryTVC.nib, forCellReuseIdentifier: HistoryTVC.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
    }
    
}

extension HistoryListView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTVC.identifier, for: indexPath) as? HistoryTVC
        else {
            return UITableViewCell()
        }
        
        cell.setupCell(data: data[indexPath.row])
        
        return cell
    }
    
}
