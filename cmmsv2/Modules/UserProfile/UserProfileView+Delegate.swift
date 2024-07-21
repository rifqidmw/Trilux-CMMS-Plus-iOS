//
//  UserProfileView+Delegate.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 04/02/24.
//

import UIKit
import Photos
import Alamofire

extension UserProfileView: LogoutPopUpBottomSheetDelegate {
    
    func didTapLogout() {
        guard let presenter,
              let logo = UserDefaults.standard.string(forKey: "triluxLogo"),
              let tagline = UserDefaults.standard.string(forKey: "tagLine"),
              let navigation = self.navigationController
        else { return }
        let data = HospitalTheme(logo: logo, tagline: tagline)
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")
        UserDefaults.standard.removeObject(forKey: "valToken")
        presenter.navigateToLoginPage(navigation: navigation, data: data)
    }
    
}

extension UserProfileView: SignatureBottomSheetDelegate {
    
    func didTapSaveSignature(signature: Data, view: SignatureBottomSheet) {
        FileUploader.uploadFile(
            fileData: signature,
            withName: "image",
            fileName: "signature.jpg",
            mimeType: "image/jpeg",
            uploadEndpoint: "media/uploadttd",
            contentType: "application/x-www-form-urlencoded",
            entityType: SignatureEntity.self,
            success: { signatureEntity in
                guard let signature = signatureEntity.data else { return }
                self.signature = signatureEntity
                self.user?.ttd = signature.base64
                view.showAlert(title: "Data berhasil diubah", message: "Berhasil mengubah tanda tangan", completion: {
                    self.dismiss(animated: true)
                })
            },
            failure: { error in
                view.showAlert(title: "Terjadi kesalahan!", message: "Error: \(error)", completion: {
                    self.dismiss(animated: true)
                })
            }
        )
    }
    
    func didTapCameraButton() {
        self.cameraSelectedType = .signature
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
    
}

extension UserProfileView: UploadMediaBottomSheetDelegate {
    
    func didSelectPictureFromCamera() {
        self.cameraSelectedType = .profile
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

extension UserProfileView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)
        
        if let selectedImage = info[.editedImage] as? UIImage,
           let imageData = selectedImage.jpegData(compressionQuality: 0.2) {
            
            let signatureCamera = self.cameraSelectedType == .signature
            
            if signatureCamera {
                FileUploader.uploadFile(
                    fileData: imageData,
                    withName: "image",
                    fileName: "signature.jpg",
                    mimeType: "image/jpeg",
                    uploadEndpoint: "media/uploadttd",
                    contentType: "application/x-www-form-urlencoded",
                    entityType: SignatureEntity.self,
                    success: { signatureEntity in
                        guard let signature = signatureEntity.data else { return }
                        self.signature = signatureEntity
                        self.user?.ttd = signature.base64
                        self.showAlert(title: "Data berhasil diubah", message: "Berhasil mengubah tanda tangan", completion: {
                            self.dismiss(animated: true)
                        })
                    },
                    failure: { error in
                        self.showAlert(title: "Terjadi kesalahan!", message: "Error: \(error)", completion: {
                            self.dismiss(animated: true)
                        })
                    }
                )
            } else {
                FileUploader.uploadFile(
                    fileData: imageData,
                    withName: "file",
                    fileName: "file.jpg",
                    mimeType: "image/jpeg",
                    uploadEndpoint: "media/uploadprofile",
                    contentType: "multipart/form-data",
                    entityType: MediaProfileEntity.self,
                    success: { mediaProfileEntity in
                        self.media = mediaProfileEntity
                        guard let presenter = self.presenter,
                              let data = self.media,
                              let user = data.data,
                              let profile = user.media,
                              let idString = profile.id,
                              let imageId = Int(idString),
                              let name = UserDefaults.standard.string(forKey: "txtName"),
                              let position = UserDefaults.standard.string(forKey: "txtJabatan"),
                              let workUnit = UserDefaults.standard.string(forKey: "txtUnitKerja"),
                              let phoneNumber = UserDefaults.standard.string(forKey: "txtTelepon")
                        else { return }
                        
                        presenter.updateProfile(name: name, position: position, workUnit: workUnit, imageId: imageId, phoneNumber: phoneNumber)
                    },
                    failure: { error in
                        self.showAlert(title: "Terjadi kesalahan!", message: "Error: \(error)")
                    }
                )
            }
            
        } else {
            self.showAlert(title: "Terjadi kesalahan!", message: "Gagal mengambil data gambar.")
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
