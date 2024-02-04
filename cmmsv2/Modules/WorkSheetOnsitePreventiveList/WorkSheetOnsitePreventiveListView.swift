//
//  WorkSheetOnsitePreventiveListView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 22/01/24.
//

import UIKit

class WorkSheetOnsitePreventiveListView: BaseViewController {
    
    @IBOutlet weak var navigationView: CustomNavigationView!
    @IBOutlet weak var tableView: UITableView!
    
    var data: [WorkSheetListEntity] = onsitePreventiveData
    var presenter: WorkSheetOnsitePreventiveListPresenter?
    
    override func didLoad() {
        super.didLoad()
        setupBody()
    }
    
}

extension WorkSheetOnsitePreventiveListView {
    
    private func setupBody() {
        setupView()
        setupAction()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(WorkSheetItemTVC.nib, forCellReuseIdentifier: WorkSheetItemTVC.identifier)
        tableView.separatorStyle = .none
    }
    
    private func setupView() {
        navigationView.configure(plainTitle: "Lembar Kerja", type: .plain)
    }
    
    private func setupAction() {
        navigationView.arrowLeftBackButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let navigation = self.navigationController
                else { return}
                navigation.popViewController(animated: true)
            }
            .store(in: &anyCancellable)
    }
    
}

extension WorkSheetOnsitePreventiveListView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WorkSheetItemTVC.identifier, for: indexPath) as? WorkSheetItemTVC
        else {
            return UITableViewCell()
        }
        
        cell.setupCell(data: data[indexPath.row], type: .preventive)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let status = data[indexPath.row].status
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        
        self.showOverlay()
        presenter.showBottomSheetAction(navigation: navigation, type: status == .ongoing ? .work : .see, delegate: self)
    }
    
}

extension WorkSheetOnsitePreventiveListView: WorkSheetOnsitePreventiveDelegate {
    
    func didTapDetailPreventive() {
        AppLogger.log("GO TO DETAIL PREVENTIVE")
    }
    
    func didTapContinueWorking() {
        AppLogger.log("GO TO INSERT PAGE")
    }
    
}
