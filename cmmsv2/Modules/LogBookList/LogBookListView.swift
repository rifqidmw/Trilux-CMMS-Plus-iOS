//
//  LogBookView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 17/03/24.
//

import UIKit
import FSCalendar
import SkeletonView

class LogBookListView: BaseViewController {
    
    @IBOutlet weak var customNavigationView: CustomNavigationView!
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var presenter: LogBookListPresenter?
    var data: LogBookListEntity?
    var date: String?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
    }
    
}

extension LogBookListView {
    
    private func setupBody() {
        fetchInitialData()
        bindingData()
        setupView()
        setupAction()
        setupCalendar()
        setupCollectionView()
    }
    
    private func setupView() {
        customNavigationView.configure(toolbarTitle: "Log Book", type: .plain)
        containerView.makeCornerRadius(24, .topCurve)
        containerView.addShadow(2.8, position: .top, opacity: 0.08)
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
        calendarView.delegate = self
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
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.collectionView.isSkeletonable = true
            self.collectionView.showAnimatedGradientSkeleton()
        }
    }
    
    private func fetchInitialData() {
        guard let presenter = presenter else { return }
        presenter.fetchInitData(date: date ?? String.getCurrentDateString("dd MMMM yyyy"))
        showSpinner(true)
    }
    
    private func bindingData() {
        guard let presenter else { return }
        presenter.$logbookList
            .sink { [weak self] data in
                guard let self
                else {
                    self?.showSpinner(false)
                    return
                }
                
                if let logBookData = data?.data, !logBookData.isEmpty,
                   let totalItems = data?.reff?.totalItem, !totalItems.isEmpty {
                    collectionView.isHidden = false
                    emptyView.isHidden = true
                    countLabel.text = "Berhasil menemukan \(totalItems) item"
                } else {
                    collectionView.isHidden = true
                    emptyView.isHidden = false
                    countLabel.text = "Tidak dapat menemukan item"
                }
                
                self.data = data
                self.collectionView.reloadData()
                self.collectionView.hideSkeleton()
                self.dateLabel.text = date ?? String.getCurrentDateString("dd MMMM yyyy")
                self.showSpinner(false)
            }
            .store(in: &anyCancellable)
    }
    
    private func showSpinner(_ isShow: Bool) {
        self.spinner.isHidden = !isShow
        isShow ? self.spinner.startAnimating() : self.spinner.stopAnimating()
    }
    
}

extension LogBookListView: FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let dateString = dateFormatter.string(from: date)
        self.date = dateString
        fetchInitialData()
    }
    
}

extension LogBookListView: SkeletonCollectionViewDataSource, SkeletonCollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        return LogBookCVC.identifier
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LogBookCVC.identifier, for: indexPath) as? LogBookCVC,
              let data = self.data?.data
        else {
            return UICollectionViewCell()
        }
        
        cell.setupCell(data: data[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 190)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard scrollView == scrollView,
              let presenter = self.presenter
        else { return }
        
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if maximumOffset - currentOffset <= 0.0 && presenter.isCanLoad {
            self.showSpinner(true)
            
            DispatchQueue.main.async {
                presenter.fetchNextPage(date: self.date ?? String.getCurrentDateString("dd MMMM yyyy"))
            }
        }
    }
    
}
