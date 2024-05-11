//
//  DetailComplaintSectionView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 21/01/24.
//

import UIKit
import Combine

class DetailComplaintSectionView: UIView {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var badgeView: UIView!
    @IBOutlet weak var badgeLabel: UILabel!
    @IBOutlet weak var topicTitleLabel: UILabel!
    @IBOutlet weak var chronologyLabel: UILabel!
    @IBOutlet weak var seeAllPicButton: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var anyCancellable = Set<AnyCancellable>()
    weak var delegate: WorkSheetDetailDelegate?
    var collectionViewData: [Media] = dummyEvidenceEquipment
    var tableViewData: [WorkSheetDetailEntity] = dummyDetailWorkSheet
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBody()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupBody()
    }
    
    private func setupBody() {
        let view = loadNib()
        view.frame = self.bounds
        self.addSubview(view)
        configureView()
    }
    
}

extension DetailComplaintSectionView {
    
    private func configureView() {
        setupAction()
        setupTableView()
        setupCollectionView()
        configureSharedComponent()
    }
    
    private func setupAction() {
        seeAllPicButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let delegate = self.delegate
                else { return }
                delegate.didTapSeeAllEvidence()
            }
            .store(in: &anyCancellable)
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(EvidenceEquipmentCVC.nib, forCellWithReuseIdentifier: EvidenceEquipmentCVC.identifier)
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 72, height: collectionView.frame.height)
        collectionView.collectionViewLayout = layout
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WorkSheetDetailTVC.nib, forCellReuseIdentifier: WorkSheetDetailTVC.identifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = 98
    }
    
    private func configureSharedComponent() {
        containerView.makeCornerRadius(8)
        containerView.addShadow(2, opacity: 0.4)
        badgeView.makeCornerRadius(4)
        seeAllPicButton.makeCornerRadius(8)
        seeAllPicButton.addShadow(2, opacity: 0.2)
    }
    
    func configure(topics: String, chronology: String, date: String, time: String, status: String) {
        dateTimeLabel.text = "\(date) • \(time)"
        badgeLabel.text = status
        topicTitleLabel.text = topics
        chronologyLabel.text = chronology
    }
    
}

extension DetailComplaintSectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionViewData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EvidenceEquipmentCVC.identifier, for: indexPath) as? EvidenceEquipmentCVC
        else {
            return UICollectionViewCell()
        }
        
        cell.setupCell(data: collectionViewData[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate = self.delegate else { return }
        delegate.didTapImage(titlePage: "Foto Kerusakan", image: collectionViewData[indexPath.row].valUrl ?? "")
    }
    
}

extension DetailComplaintSectionView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WorkSheetDetailTVC.identifier, for: indexPath) as? WorkSheetDetailTVC
        else {
            return UITableViewCell()
        }
        
        cell.setupCell(data: tableViewData[indexPath.row])
        
        return cell
    }
    
}
