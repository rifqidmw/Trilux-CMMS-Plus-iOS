//
//  FileDownloader.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/06/24.
//

import UIKit

func openPDF(with id: String, onFailure: @escaping (String) -> Void) {
    guard !id.isEmpty else {
        onFailure("Invalid ID or base URL.")
        return
    }
    
    let urlString = "http://dev.triluxcmms.com/site/lk_pdf/\(id)"
    
    guard let url = URL(string: urlString) else {
        onFailure("Invalid URL.")
        return
    }
    
    UIApplication.shared.open(url, options: [:]) { success in
        if !success {
            onFailure("Failed to open the URL.")
        }
    }
}
