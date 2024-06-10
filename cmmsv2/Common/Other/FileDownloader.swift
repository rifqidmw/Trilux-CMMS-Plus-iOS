//
//  FileDownloader.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 09/06/24.
//

import Foundation
import Combine
import UIKit

class FileDownloader: NSObject, UIDocumentInteractionControllerDelegate {
    static let shared = FileDownloader()
    private override init() {}
    
    private var documentInteractionController: UIDocumentInteractionController?
    
    func downloadFile(from urlString: String) -> AnyPublisher<URL, Error> {
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.downloadTaskPublisher(for: url)
            .map(\.url)
            .eraseToAnyPublisher()
    }
    
    func openFile(_ localURL: URL, from viewController: UIViewController) {
        documentInteractionController = UIDocumentInteractionController(url: localURL)
        documentInteractionController?.delegate = self
        documentInteractionController?.presentPreview(animated: true)
    }
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return UIApplication.shared.windows.first!.rootViewController!
    }
}

extension URLSession {
    func downloadTaskPublisher(for url: URL) -> AnyPublisher<(url: URL, response: URLResponse), Error> {
        return Future { promise in
            let task = self.downloadTask(with: url) { url, response, error in
                if let url = url, let response = response {
                    promise(.success((url: url, response: response)))
                } else if let error = error {
                    promise(.failure(error))
                }
            }
            task.resume()
        }
        .eraseToAnyPublisher()
    }
}
