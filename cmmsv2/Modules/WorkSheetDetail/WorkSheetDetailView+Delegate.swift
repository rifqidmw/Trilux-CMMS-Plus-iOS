//
//  WorkSheetDetailView+Delegate.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 02/06/24.
//

import UIKit
import Photos
import Alamofire

extension WorkSheetDetailView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension WorkSheetDetailView: InputBottomSheetDelegate {
    
    func didTapSubmit(_ text: String, type: InputBottomSheetType) {
        switch type {
        case .text:
            let newTask = TaskLK(idLktask: "0", lkTask: text)
            self.addTaskSectionView.addTask(newTask)
        case .number:
            guard let presenter,
                  let activity = presenter.activity,
                  let selectedSparePart,
                  let text = Int(text) else { return }
            
            let jumlahTotal = (selectedSparePart.harga ?? 0) * text
            let newSparePart = LKData.Sparepart(
                idLksparepart: "",
                idPart: selectedSparePart.idPart ?? "",
                jumlah: String(text),
                harga: String(selectedSparePart.harga ?? 0),
                partname: selectedSparePart.name ?? "",
                jumlahTotal: String(jumlahTotal)
            )
            
            if self.selectedSparePartType == .usage {
                self.addUsageSparePartSectionView.addSparePart(newSparePart, activity: activity)
            } else if self.selectedSparePartType == .requirement {
                self.addRequirementSparePartSectionView.addSparePart(newSparePart, activity: activity)
            }
        }
    }
    
}

extension WorkSheetDetailView: SparePartBottomSheetDelegate {
    
    func didSelectSparePart(_ sparepartName: String) {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        if let selectedSparePart = presenter.sparePartList.first(where: { $0.name == sparepartName }) {
            self.selectedSparePart = selectedSparePart
            presenter.showInputBottomSheet(from: navigation, delegate: self, type: .number)
        }
    }
    
}

extension WorkSheetDetailView: SelectStatusBottomSheetDelegate, StatusSectionDelegate {
    
    func didTapSelectStatus() {
        guard let presenter,
              let navigation = self.navigationController else { return }
        presenter.showSelectStatusBottomSheet(from: navigation, delegate: self, type: .normal)
    }
    
    func didTapSelectFinishStatus() {
        guard let presenter,
              let navigation = self.navigationController else { return }
        presenter.showSelectStatusBottomSheet(from: navigation, delegate: self, type: .finish)
    }
    
    func didSelectStatus(_ status: WorkingStatusEntity) {
        self.selectStatusSectionView.statusData = status
        if status.lkStatus == "3" {
            self.selectStatusHeightConstraint.constant = 224
        } else {
            self.selectStatusHeightConstraint.constant = 144
        }
        self.selectStatusContainerStackView.layoutIfNeeded()
    }
    
    func didSelectFinishStatus(_ finishStatus: WorkingFinishStatusEntity) {
        self.selectStatusSectionView.finishStatusData = finishStatus
        self.selectStatusHeightConstraint.constant = 224
        self.selectStatusContainerStackView.layoutIfNeeded()
    }
    
}

extension WorkSheetDetailView: MediaSectionViewDelegate {
    
    func didTapAddMedia() {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.showUploadMediaBottomSheet(navigation: navigation, delegate: self)
    }
    
    func didTapSeeDetailMedia(_ url: String) {
        guard let presenter,
              let navigation = self.navigationController
        else { return }
        presenter.navigateToDetailDocument(navigation: navigation, file: url)
    }
    
}

extension WorkSheetDetailView: UploadMediaBottomSheetDelegate {
    
    func didSelectPictureFromCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.dismiss(animated: true) {
                UIApplication.topViewController()?.present(imagePicker, animated: true, completion: nil)
            }
        } else {
            self.showAlert(title: "Terjadi kesalahan", message: "Kamera tidak tersedia")
        }
    }
    
    func didSelectPictureFromGaleri() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            imagePicker.modalPresentationStyle = .overFullScreen
            imagePicker.delegate = self
            self.dismiss(animated: true) {
                UIApplication.topViewController()?.present(imagePicker, animated: true, completion: nil)
            }
        } else {
            self.showAlert(title: "Terjadi kesalahan", message: "Galeri tidak tersedia")
        }
    }
    
}

extension WorkSheetDetailView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)
        
        guard let selectedImage = info[.editedImage] as? UIImage,
              let imageData = selectedImage.jpegData(compressionQuality: 0.2) else {
            return
        }
        
        FileUploader.uploadFile(
            fileData: imageData,
            withName: "file",
            fileName: "file.jpg",
            mimeType: "image/jpeg",
            uploadEndpoint: "media/uploadlk",
            contentType: "multipart/form-data",
            entityType: MediaEntity.self,
            success: { mediaResponse in
                self.media = mediaResponse
                guard let data = self.media,
                      let mediaList = data.data,
                      let media = mediaList.medias
                else { return }
                
                let newMedia = media.map { media in
                    LKData.Lkphoto(idLkphoto: "", filename: "", note: "", photoID: media.id, photoUrl: media.valUrl)
                }
                
                newMedia.forEach { media in
                    self.mediaSectionView.addMedia(media)
                }
            },
            failure: { error in
                self.showAlert(title: "Terjadi kesalahan!", message: "Error: \(error.localizedDescription)")
            }
        )
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
