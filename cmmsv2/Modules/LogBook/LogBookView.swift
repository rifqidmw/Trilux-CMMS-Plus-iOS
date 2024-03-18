//
//  LogBookView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 17/03/24.
//

import UIKit
import FSCalendar

class LogBookView: BaseViewController {
    
    @IBOutlet weak var customNavigationView: CustomNavigationView!
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: LogBookPresenter?
    var data: [LogBookEntity] = logBookDataList
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
    }
    
}

extension LogBookView {
    
    private func setupBody() {
        setupView()
        setupAction()
        setupCalendar()
        setupCollectionView()
    }
    
    private func setupView() {
        customNavigationView.configure(plainTitle: "Log Book", type: .plain)
        containerView.makeCornerRadius(24, .topCurve)
        containerView.addShadow(2.8, position: .top, opacity: 0.08)
        collectionView.isHidden = data.isEmpty
        emptyView.isHidden = !data.isEmpty
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
    
    private func setupCalendar() {
        calendarView.scrollDirection = .horizontal
        calendarView.appearance.todayColor = UIColor.customPrimaryColor
        calendarView.appearance.selectionColor = UIColor.customSecondaryColor
        calendarView.appearance.titleSelectionColor = UIColor.customDarkGrayColor
        calendarView.appearance.headerTitleColor = UIColor.customPrimaryColor
        calendarView.appearance.weekdayTextColor = UIColor.customDarkGrayColor
        calendarView.appearance.headerTitleFont = UIFont.latoBold(16)
        calendarView.appearance.weekdayFont = UIFont.latoBold(14)
        calendarView.appearance.titleFont = UIFont.latoRegular(12)
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(LogBookCVC.nib, forCellWithReuseIdentifier: LogBookCVC.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: collectionView.frame.size.width, height: 190)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        collectionView.collectionViewLayout = layout
    }
    
}

extension LogBookView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LogBookCVC.identifier, for: indexPath) as? LogBookCVC
        else {
            return UICollectionViewCell()
        }
        
        cell.setupCell(data: data[indexPath.row])
        
        return cell
    }
    
}
