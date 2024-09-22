//
//  EditComplaintView+Delegate.swift
//  cmmsv2
//
//  Created by macbook  on 22/09/24.
//

import UIKit

extension EditComplaintView: UploadMediaBottomSheetDelegate {
    
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

extension EditComplaintView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
            uploadEndpoint: "media/uploadkorektif",
            contentType: "multipart/form-data",
            entityType: EditComplaintMediaEntity.self,
            success: { mediaResponse in
                self.medias.append(contentsOf: mediaResponse.data?.medias ?? [])
                let uploadedMediaIds = mediaResponse.data?.medias?.compactMap { $0.id } ?? []
                self.mediaId.append(contentsOf: uploadedMediaIds)
                self.updateUploadStackViewVisibility()
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
