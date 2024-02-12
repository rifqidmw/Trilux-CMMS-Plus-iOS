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
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        print("SELECTED IMAGE: \(selectedImage)")
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
