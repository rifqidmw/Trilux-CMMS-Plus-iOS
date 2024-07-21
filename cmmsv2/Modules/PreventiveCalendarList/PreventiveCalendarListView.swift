//
//  PreventiveCalendarListView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 18/03/24.
//

import UIKit
import FSCalendar
import SkeletonView

class PreventiveCalendarListView: BaseViewController {
    
    @IBOutlet weak var customNavigationView: CustomNavigationView!
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var filterButton: UILabel!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var presenter: PreventiveCalendarListPresenter?
    var preventiveData: [PreventiveScheduleData] = []
    var data: [WorkSheetListEntity] = []
    var date: String?
    var month: String?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.validateUser()
    }
    
}

extension PreventiveCalendarListView {
    
    private func setupBody() {
        fetchInitialData()
        bindingData()
        setupView()
        setupAction()
        setupCalendar()
        setupCollectionView()
    }
    
    private func setupView() {
        customNavigationView.configure(toolbarTitle: "Kalender Preventif", type: .plain)
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
        calendarView.appearance.calendar.delegate = self
        calendarView.delegate = self
        calendarView.scrollDirection = .horizontal
        calendarView.appearance.todayColor = UIColor.customGreenColor
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
        collectionView.register(WorkSheetCVC.nib, forCellWithReuseIdentifier: WorkSheetCVC.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.collectionView.isSkeletonable = true
            self.collectionView.showAnimatedGradientSkeleton()
        }
    }
    
    private func fetchInitialData() {
        guard let presenter = presenter else { return }
        presenter.fetchInitData(month: self.month ?? String.getCurrentDateString("yyyy-MM-dd"))
        showSpinner(true)
    }
    
    private func bindingData() {
        guard let presenter else { return }
        presenter.$preventiveList
            .sink { [weak self] data in
                guard let self
                else {
                    self?.showSpinner(false)
                    return
                }
                
                self.preventiveData = data
                self.collectionView.reloadData()
                self.collectionView.hideSkeleton()
                self.calendarView.reloadData()
                self.showSpinner(false)
            }
            .store(in: &anyCancellable)
        
        presenter.$preventiveScheduleList
            .sink { [weak self] data in
                guard let self
                else {
                    self?.showSpinner(false)
                    return
                }
                
                if data.isEmpty {
                    self.collectionView.isHidden = true
                    self.emptyView.isHidden = false
                    self.countLabel.text = "Tidak dapat menemukan item"
                } else {
                    self.collectionView.isHidden = false
                    self.emptyView.isHidden = true
                    self.countLabel.text = "Berhasil menemukan \(data.count) item"
                }
                
                self.data = data
                self.collectionView.reloadData()
                self.collectionView.hideSkeleton()
                self.dateLabel.text = date ?? String.getCurrentDateString("yyyy-MM-dd")
                self.showSpinner(false)
            }
            .store(in: &anyCancellable)
    }
    
    private func showSpinner(_ isShow: Bool) {
        self.spinner.isHidden = !isShow
        isShow ? self.spinner.startAnimating() : self.spinner.stopAnimating()
    }
    
}

extension PreventiveCalendarListView: FSCalendarDelegate, FSCalendarDelegateAppearance {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        guard let presenter = presenter else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        self.date = dateString
        
        self.fetchInitialData()
        presenter.fetchPreventiveSchedule(idEngineer: "", date: dateString)
        showSpinner(true)
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        let currentPageDate = calendar.currentPage
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let monthString = dateFormatter.string(from: currentPageDate)
        
        self.month = monthString
        fetchInitialData()
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        
        return preventiveData.contains { $0.date == dateString }
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        
        if preventiveData.contains(where: { $0.date == dateString }) {
            return UIColor.customPrimaryColor
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        
        if preventiveData.contains(where: { $0.date == dateString }) {
            return .white
        }
        return nil
    }
    
}

extension PreventiveCalendarListView: SkeletonCollectionViewDataSource, SkeletonCollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        return WorkSheetCVC.identifier
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkSheetCVC.identifier, for: indexPath) as? WorkSheetCVC
        else {
            return UICollectionViewCell()
        }
        
        cell.setupCell(data: data[indexPath.row], type: .preventiveCalendar)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let presenter,
              let navigation = self.navigationController,
              let status = self.data[indexPath.row].status
        else { return }
        if status == .done {
            self.showOverlay()
            presenter.showPreventiveBottomSheet(from: navigation, delegate: self)
        } else {
            presenter.navigateToLoadPreventive(from: navigation, data: self.data[indexPath.row])
        }
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
                presenter.fetchNextPage(date: self.date ?? String.getCurrentDateString("yyyy-MM-dd"))
            }
        }
    }
    
}

extension PreventiveCalendarListView: PreventiveSchedulerBottomSheetDelegate {
    
    func didTapCreatePreventive() {
        AppLogger.log("-- CLICKED")
    }
    
}
