//
//  MediaSectionView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 14/07/24.
//

import UIKit
import Combine

protocol MediaSectionViewDelegate: AnyObject {
    func didTapAddMedia()
    func didTapSeeDetailMedia(_ url: String)
}

class MediaSectionView: UIView {
    
    @IBOutlet weak var addMediaButton: UIView!
    @IBOutlet weak var addMediaImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var emptyView: UIView!
    
    var activityType: WorkSheetActivityType?
    var medias: [LKData.Lkphoto] = []
    weak var delegate: MediaSectionViewDelegate?
    var anyCancellable = Set<AnyCancellable>()
    
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
        self.setupCollectionView()
        self.setupAction()
    }
    
}

extension MediaSectionView {
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(EvidenceEquipmentCVC.nib, forCellWithReuseIdentifier: EvidenceEquipmentCVC.identifier)
        addMediaButton.makeCornerRadius(8)
        addMediaImageView.makeCornerRadius(8)
    }
    
    func configure(data: [LKData.Lkphoto], activity: WorkSheetActivityType) {
        self.medias = data
        self.collectionView.reloadData()
        self.activityType = activity
        self.emptyView.isHidden = !data.isEmpty || activity == .working
        if activity == .view {
            self.collectionView.isHidden = data.isEmpty
        } else {
            self.collectionView.isHidden = false
            self.addMediaButton.isHidden = false
        }
    }
    
    func addMedia(_ data: LKData.Lkphoto) {
        self.medias.append(data)
        self.collectionView.reloadData()
    }
    
    func removeLocalImage(at indexPath: IndexPath) {
        let adjustedIndex = indexPath.row
        medias.remove(at: adjustedIndex)
        collectionView.reloadData()
    }
    
    func getAllMediaData() -> [PhotoLK] {
        var allMedia: [PhotoLK] = []
        for (_, media) in medias.enumerated() {
            let updateMedia = PhotoLK(
                filename: "",
                idLkphoto: "",
                note: "",
                photoUrl: media.photoUrl ?? "",
                photoID: media.photoID ?? "")
            allMedia.append(updateMedia)
        }
        return allMedia
    }
    
    private func setupAction() {
        addMediaButton.gesture()
            .sink { [weak self] _ in
                guard let self, let delegate = self.delegate else { return }
                delegate.didTapAddMedia()
            }
            .store(in: &anyCancellable)
    }
    
}

extension MediaSectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.medias.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EvidenceEquipmentCVC.identifier, for: indexPath) as? EvidenceEquipmentCVC else {
            return UICollectionViewCell()
        }
        
        let index = indexPath.row
        cell.setupCell(url: self.medias[index].photoUrl, type: activityType == .view ? .view : .upload, indexPath: indexPath, delegate: self)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate = self.delegate else { return }
        if activityType == .view {
            let selectedDamagedPicture = self.medias[indexPath.row].photoUrl ?? ""
            delegate.didTapSeeDetailMedia(selectedDamagedPicture)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGSize.widthDevice / 3.8, height: collectionView.frame.height)
    }
    
}

extension MediaSectionView: EvidenceEquipmentCellDelegate {
    
    func didRemoveMedia(_ indexPath: IndexPath) {
        self.removeLocalImage(at: indexPath)
    }
    
}
