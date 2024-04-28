//
//  UserProfileEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/01/24.
//

import Foundation

protocol ChangePictureBottomSheetDelegate: AnyObject {
    func didSelectPictureFromCamera()
    func didSelectPictureFromGaleri()
}

struct MediaProfileEntity: Codable {
    let data: ProfileData?
    let message: String?
    let status: Int?
    
    enum CodingKeys: CodingKey {
        case data
        case message
        case status
    }
}

struct ProfileData: Codable {
    let media: DetailProfile?
    
    enum CodingKeys: CodingKey {
        case media
    }
}

struct DetailProfile: Codable {
    let id: String?
    let valUrl: String?
    let valThumburl: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case valUrl = "valUrl"
        case valThumburl = "valThumburl"
    }
}

struct ProfileMenuModel: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let desc: String
}

let profileMenuData: [ProfileMenuModel] = [
    ProfileMenuModel(image: "ic_user_with_gear", title: "Ubah Profile", desc: "Ubah profile sesuai keinginan Anda"),
    ProfileMenuModel(image: "ic_padlock", title: "Ganti Password", desc: "Ganti password sesuai keinginan Anda"),
    ProfileMenuModel(image: "ic_padlock", title: "Ganti Tanda Tangan", desc: "Ganti tanda tangan sesuai keinginan Anda")
]

let changePictureData: [MenuModel] = [
    MenuModel(image: "ic_camera_fill", title: "Kamera", subTitle: "Ambil gambar terkini"),
    MenuModel(image: "ic_gallery_fill", title: "Galeri", subTitle: "Ambil gambar dari galeri")
]
