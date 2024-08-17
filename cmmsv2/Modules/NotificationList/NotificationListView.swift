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
        self.setupBody()
        self.validateUser()
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
                self.reloadCollectionViewWithAnimation(self.collectionView)
                self.collectionView.hideSkeleton()
                self.showSpinner(false)
            }
            .store(in: &anyCancellable)
        
        presenter.$workSheetData
            .sink { [weak self] data in
                guard let self else { return }
                self.workSheetData = data
                self.reloadCollectionViewWithAnimation(self.collectionView)
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
        
        presenter.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                guard let self else { return }
                isLoading ? self.collectionView.showAnimatedGradientSkeleton() : self.collectionView.hideSkeleton()
            }
            .store(in: &anyCancellable)
        
    }
    
    private func setupView() {
        customNavigationView.configure(toolbarTitle: "Notifikasi", type: .plain)
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
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
        collectionView.isSkeletonable = true
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
        
        let sortedResult = result.sorted {
            guard let date1 = dateFromString($0.notifications.first?.time ?? ""),
                  let date2 = dateFromString($1.notifications.first?.time ?? "") else { return false }
            return date1 > date2
        }
        
        return sortedResult
    }
    
    func getTimeCategoryHeader(for date: String) -> String {
        return getTimeCategory(for: date)
    }
    
    private func getTimeCategory(for dateString: String) -> String {
        guard let date = dateFromString(dateString) else {
            return "Unknown"
        }
        
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.year, .month, .day], from: date, to: now)
        
        if let year = components.year, year > 0 {
            return year > 1 ? "\(year) Tahun lalu" : "Tahun lalu"
        } else if let month = components.month, month > 0 {
            return month > 1 ? "\(month) Bulan lalu" : "Bulan lalu"
        } else if let day = components.day, day > 0 {
            return "Bulan ini"
        } else {
            return "Hari ini"
        }
    }
    
    private func dateFromString(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: dateString)
    }
    
}

extension NotificationListView: SkeletonCollectionViewDelegate, SkeletonCollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, skeletonCellForItemAt indexPath: IndexPath) -> UICollectionViewCell? {
        return collectionView.dequeueReusableCell(withReuseIdentifier: NotificationItemCVC.identifier, for: indexPath)
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
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
                presenter.showBottomSheetCorrective(navigation: navigation, data: workOrderData, delegate: self)
            } else {
                self.showAlert(title: "Terjadi Kesalahan", message: "Tidak ada data yang cocok")
            }
        case .complaint:
            if let complaintData = self.complaintData.first(where: { $0.id == itemId }) {
                presenter.navigateToComplaintDetail(navigation: navigation, id: String(complaintData.id ?? 0))
            } else {
                self.showAlert(title: "Terjadi Kesalahan", message: "Tidak ada data yang cocok")
            }
        case .approveLk:
            if let id = self.data[indexPath.row].item_id {
                if id.starts(with: "index?") {
                    self.showAlert(title: "Terjadi Kesalahan", message: "Tidak ada data yang cocok")
                } else {
                    presenter.navigateToWorkSheetApprovalDetail(from: navigation, id: id)
                }
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 38)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}
