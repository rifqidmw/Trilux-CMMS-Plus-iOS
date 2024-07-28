//
//  FileUploader.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 29/04/24.
//

import Foundation
import Alamofire
import Combine

class FileUploader {
    
    static func uploadFile<T: Decodable>(
        fileData: Data,
        withName: String,
        fileName: String,
        mimeType: String,
        uploadEndpoint: String,
        contentType: String,
        entityType: T.Type,
        success: @escaping (T) -> Void,
        failure: @escaping (Error) -> Void
    ) {
        let headers: HTTPHeaders = [
            "Content-Type": contentType,
            "Authorizations": Constants.token,
            "RequestType": "api",
            "Accept": "*/*"
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(fileData, withName: withName, fileName: fileName, mimeType: mimeType)
        }, to: Constants.baseURL + uploadEndpoint, headers: headers)
        .responseDecodable(of: entityType) { response in
            switch response.result {
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
}
