//
//  HelpBannerView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 28/06/24.
//

import UIKit

class HelpBannerView: UIView {
    
    @IBOutlet weak var containerInstructionStackView: UIStackView!
    @IBOutlet weak var instructionTableView: UITableView!
    var instructionData: [String] = [
        "Aktifkan Abaikan jika data tidak ingin ditampilkan",
        "Centang jika label dalam kondisi baik"
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        let view = loadNib()
        view.frame = self.bounds
        self.addSubview(view)
        self.configureSharedComponent()
        self.setupTableView()
    }
    
}

extension HelpBannerView {
    
    private func setupTableView() {
        instructionTableView.dataSource = self
        instructionTableView.delegate = self
        instructionTableView.register(InstructionCell.nib, forCellReuseIdentifier: InstructionCell.identifier)
        instructionTableView.separatorStyle = .none
    }
    
    private func configureSharedComponent() {
        containerInstructionStackView.makeCornerRadius(8)
    }
    
}

extension HelpBannerView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.instructionData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InstructionCell.identifier, for: indexPath) as? InstructionCell
        else {
            return UITableViewCell()
        }
        
        cell.setupCell(title: self.instructionData[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 18.0
    }
    
}
