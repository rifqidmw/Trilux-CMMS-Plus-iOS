// 
//  WorkSheetListView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 14/01/24.
//

import UIKit

class WorkSheetListView: BaseViewController {
    
    @IBOutlet weak var navigationView: CustomNavigationView!
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: WorkSheetListPresenter?
    var data: [WorkSheetListEntity] = workSheetData

    override func didLoad() {
        super.didLoad()
        setupBody()
    }

}

extension WorkSheetListView {
    
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
                      let presenter
                else { return}
                
                presenter.backToPreviousPage()
            }
            .store(in: &anyCancellable)
    }
    
}

extension WorkSheetListView: UITableViewDataSource, UITableViewDelegate {
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        self.showOverlay()
        presenter.showBottomSheetPreviewWorkSheet(navigation: navigation)
    }
    
}
