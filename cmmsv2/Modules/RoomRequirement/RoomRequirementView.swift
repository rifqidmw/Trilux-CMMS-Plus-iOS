//
//  RoomRequirementView.swift
//  cmmsv2
//
//  Created by macbook  on 10/09/24.
//

import UIKit

class RoomRequirementView: BaseViewController {
    
    @IBOutlet weak var customNavigationView: CustomNavigationView!
    @IBOutlet weak var searchTextField: SearchTextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var actionBarView: ActionBarView!
    @IBOutlet weak var addCircleButton: UIView!
    
    var presenter: RoomRequirementPresenter?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
    }
    
}

extension RoomRequirementView {
    
    private func setupBody() {
        setupView()
        setupAction()
    }
    
    private func setupView() {
        customNavigationView.configure(toolbarTitle: "Kebutuhan Ruangan", type: .plain)
        addCircleButton.layer.cornerRadius = addCircleButton.bounds.width / 2
        addCircleButton.clipsToBounds = true
        addCircleButton.addShadow(2.0, position: .bottom, opacity: 0.2)
        searchTextField.addShadow(2.0, position: .bottom, opacity: 0.2)
        actionBarView.configure()
        actionBarView.configure(
            firstIcon: "circle.grid.2x2",
            firstTitle: "Tahun",
            secondIcon: "wrench.and.screwdriver",
            secondTitle: "Kondisi",
            thirdIcon: "arrow.up.arrow.down.square",
            thirdTitle: "Urutkan")
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
    
}
