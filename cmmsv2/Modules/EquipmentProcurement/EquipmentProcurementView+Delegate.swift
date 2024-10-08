//
//  EquipmentProcurementView+Delegate.swift
//  cmmsv2
//
//  Created by macbook  on 07/10/24.
//

import UIKit

extension EquipmentProcurementView: MediaSectionViewDelegate {
    
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

extension EquipmentProcurementView: UploadMediaBottomSheetDelegate {
    
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

extension EquipmentProcurementView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
                //                self.media = mediaResponse
                //                guard let data = self.media,
                //                      let mediaList = data.data,
                //                      let media = mediaList.medias
                //                else { return }
                //
                //                let newMedia = media.map { media in
                //                    LKData.Lkphoto(idLkphoto: "", filename: "", note: "", photoID: media.id, photoUrl: media.valUrl)
                //                }
                //
                //                newMedia.forEach { media in
                //                    self.mediaSectionView.addMedia(media)
                //                }
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
