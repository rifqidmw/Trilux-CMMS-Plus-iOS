//
//  WorkSheetCorrectiveView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/03/24.
//

import UIKit

class WorkSheetCorrectiveView: BaseViewController {
    
    @IBOutlet weak var customNavigationView: CustomNavigationView!
    @IBOutlet weak var searchButton: GeneralButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var actionBarView: ActionBarView!
    
    var presenter: WorkSheetCorrectivePresenter?
    var data: [WorkSheetListEntity] = workSheetData
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
    }
    
}

extension WorkSheetCorrectiveView {
    
    private func setupBody() {
        setupView()
        setupAction()
        setupTableView()
    }
    
    private func setupView() {
        customNavigationView.configure(plainTitle: "Lembar Kerja Korektif", type: .plain)
        searchButton.configure(type: .searchbutton)
        actionBarView.configure(thirdIcon: "ic_setting", thirdTitle: "Status", fourthIcon: "ic_arrow_up_down", fourthTitle: "Urutkan")
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
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(WorkSheetItemTVC.nib, forCellReuseIdentifier: WorkSheetItemTVC.identifier)
        tableView.separatorStyle = .none
    }
    
}

extension WorkSheetCorrectiveView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WorkSheetItemTVC.identifier, for: indexPath) as? WorkSheetItemTVC
        else {
            return UITableViewCell()
        }
        
        cell.setupCell(data: data[indexPath.row], type: .normal)
        
        return cell
    }
    
}
