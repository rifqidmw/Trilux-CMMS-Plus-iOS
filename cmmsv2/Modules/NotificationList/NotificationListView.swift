//
//  NotificationListView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 18/02/24.
//

import UIKit
import SkeletonView

class NotificationListView: BaseViewController {
    
    @IBOutlet weak var customNavigationView: CustomNavigationView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var presenter: NotificationListPresenter?
    var data: [NotificationList] = []
    var workSheetData: [WorkOrder] = []
    var complaintData: [Complaint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBody()
    }
    
}

extension NotificationListView {
    
    private func setupBody() {
        fetchInitData()
        bindingData()
        setupView()
        setupAction()
        setupCollectionView()
    }
    
    private func fetchInitData() {
        guard let presenter else { return }
        presenter.fetchInitData()
    }
    
    private func bindingData() {
        guard let presenter else { return }
        presenter.$notification
            .sink { [weak self] data in
                guard let self else {
                    self?.showSpinner(false)
                    return
                }
                self.data = data
                self.collectionView.reloadData()
                self.collectionView.hideSkeleton()
                self.showSpinner(false)
            }
            .store(in: &anyCancellable)
        
        presenter.$workSheetData
            .sink { [weak self] data in
                guard let self else { return }
                self.workSheetData = data
                self.collectionView.reloadData()
                self.collectionView.hideSkeleton()
                self.showSpinner(false)
            }
            .store(in: &anyCancellable)
        
        presenter.$complaintData
            .sink { [weak self] data in
                guard let self else { return }
                self.complaintData = data
                self.collectionView.reloadData()
                self.collectionView.hideSkeleton()
                self.showSpinner(false)
            }
            .store(in: &anyCancellable)
        
    }
    
    private func setupView() {
        customNavigationView.configure(toolbarTitle: "Notifikasi", type: .plain)
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.collectionView.isSkeletonable = true
            self.collectionView.showAnimatedGradientSkeleton()
        }
        
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
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(NotificationItemCVC.nib, forCellWithReuseIdentifier: NotificationItemCVC.identifier)
        self.collectionView.register(
            TimeGroupHeaderCRV.nib,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TimeGroupHeaderCRV.identifier)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: collectionView.frame.size.width, height: 110)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.headerReferenceSize = CGSize(width: collectionView.frame.size.width, height: 38)
        collectionView.collectionViewLayout = layout
        collectionView.isSkeletonable = true
        collectionView.showAnimatedGradientSkeleton()
    }
    
    private func showSpinner(_ isShow: Bool) {
        self.spinner.isHidden = !isShow
        isShow ? self.spinner.startAnimating() : self.spinner.stopAnimating()
    }
    
    func notificationsGroupedByTime() -> [(time: String, notifications: [NotificationList])] {
        var groupedNotifications: [String: [NotificationList]] = [:]
        
        for notification in data {
            let timeCategory = getTimeCategoryHeader(for: notification.time ?? "")
            if var notificationsForTime = groupedNotifications[timeCategory] {
                notificationsForTime.append(notification)
                groupedNotifications[timeCategory] = notificationsForTime
            } else {
                groupedNotifications[timeCategory] = [notification]
            }
        }
        
        let result = groupedNotifications.map { (time: $0.key, notifications: $0.value) }
        
        let sortedResult = result.sorted { $0.time > $1.time }
        
        return sortedResult
    }
    
    
    func getTimeCategoryHeader(for date: String) -> String {
        let timeCategory = getTimeCategory(for: date)
        return timeCategory
    }
    
    private func getTimeCategory(for dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = dateFormatter.date(from: dateString) else {
            return "Unknown"
        }
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date, to: Date())
        
        if let year = components.year, year > 2 {
            return "\(year) Tahun lalu"
        } else if let year = components.year, year == 2 {
            return "2 Tahun lalu"
        } else if let year = components.year, year == 1 {
            return "Tahun lalu"
        } else if let month = components.month, month > 1 {
            return "\(month) Bulan lalu"
        } else if let month = components.month, month == 1 {
            return "Bulan lalu"
        } else if let day = components.day, day > 0 {
            return "Bulan ini"
        } else {
            return "Hari ini"
        }
    }
    
}

extension NotificationListView: SkeletonCollectionViewDelegate, SkeletonCollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, skeletonCellForItemAt indexPath: IndexPath) -> UICollectionViewCell? {
        return collectionView.dequeueReusableCell(withReuseIdentifier: NotificationItemCVC.identifier, for: indexPath)
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return NotificationItemCVC.identifier
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, supplementaryViewIdentifierOfKind: String, at indexPath: IndexPath) -> ReusableCellIdentifier? {
        return TimeGroupHeaderCRV.identifier
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let groupedNotifications = notificationsGroupedByTime()
        return groupedNotifications[section].notifications.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NotificationItemCVC.identifier, for: indexPath) as? NotificationItemCVC else {
            return UICollectionViewCell()
        }
        
        let groupedNotifications = notificationsGroupedByTime()
        let notification = groupedNotifications[indexPath.section].notifications[indexPath.row]
        
        cell.setupCell(data: notification)
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let groupedNotifications = notificationsGroupedByTime()
        return groupedNotifications.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TimeGroupHeaderCRV.identifier, for: indexPath) as? TimeGroupHeaderCRV else {
            return UICollectionReusableView()
        }
        
        let groupedNotifications = notificationsGroupedByTime()
        let timeCategory = groupedNotifications[indexPath.section].time
        header.configure(date: timeCategory)
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let presenter,
              let navigation = self.navigationController else { return }
        
        let groupedNotifications = notificationsGroupedByTime()
        let selectedData = groupedNotifications[indexPath.section].notifications[indexPath.row]
        guard let selectedType = selectedData.type_string,
              let itemIdString = selectedData.item_id,
              let itemId = Int(itemIdString) else { return }
        
        switch selectedType {
        case .worksheet:
            if let workOrderData = self.workSheetData.first(where: { $0.id == itemId }) {
                self.showOverlay()
                presenter.showBottomSheetCorrective(navigation: navigation, data: workOrderData, delegate: self)
            } else {
                self.showAlert(title: "Terjadi Kesalahan", message: "Tidak ada data yang cocok")
            }
        case .complaint:
            if let complaintData = self.complaintData.first(where: { $0.id == itemId }) {
                presenter.navigateToComplaintDetail(navigation: navigation, data: complaintData)
            } else {
                self.showAlert(title: "Terjadi Kesalahan", message: "Tidak ada data yang cocok")
            }
        default:
            break
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
                presenter.fetchNextPage()
            }
        }
    }
    
}
