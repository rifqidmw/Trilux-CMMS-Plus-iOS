// 
//  UserProfileEntity.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/01/24.
//

import Foundation

struct ProfileMenuModel: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let desc: String
}

let profileMenuData: [ProfileMenuModel] = [
    ProfileMenuModel(image: "ic_user_with_gear", title: "Ubah Profile", desc: "Ubah profile sesuai keinginan Anda"),
    ProfileMenuModel(image: "ic_padlock", title: "Ganti Password", desc: "Ganti password sesuai keinginan Anda")
]

let changePictureData: [MenuModel] = [
    MenuModel(image: "ic_camera_fill", title: "Kamera", subTitle: "Ambil gambar terkini"),
    MenuModel(image: "ic_gallery_fill", title: "Galeri", subTitle: "Ambil gambar dari galeri")
]
