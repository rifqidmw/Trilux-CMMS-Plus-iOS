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

extension UserProfileView: ChangePictureBottomSheetDelegate {
    
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

extension UserProfileView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)
        
        if let selectedImage = info[.editedImage] as? UIImage,
           let imageData = selectedImage.jpegData(compressionQuality: 0.2) {
            
            let headers: HTTPHeaders = [
                "Content-Type": "multipart/form-data",
                "Authorizations": Constants.token,
                "RequestType": "api",
                "Accept": "*/*"
            ]
            
            AF.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(imageData, withName: "file", fileName: "file.jpg", mimeType: "image/jpeg")
            }, to: "http://dev.triluxcmms.com/api/v1/media/uploadprofile", headers: headers)
            .responseDecodable(of: MediaProfileEntity.self) { response in
                switch response.result {
                case .success(let mediaProfileEntity):
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
                    
                    presenter.uploadProfile(name: name, position: position, workUnit: workUnit, imageId: imageId, phoneNumber: phoneNumber)
                case .failure(let error):
                    self.showAlert(title: "Terjadi kesalahan!", message: "Error: \(error)")
                }
            }
        } else {
            self.showAlert(title: "Terjadi kesalahan!", message: "Gagal mengambil data gambar.")
        }
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
