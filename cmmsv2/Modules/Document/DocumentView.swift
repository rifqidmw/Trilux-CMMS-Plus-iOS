//
//  DocumentView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 05/08/24.
//

import UIKit
import PDFKit

class DocumentView: BaseViewController {
    
    @IBOutlet weak var customNavigationView: CustomNavigationView!
    @IBOutlet weak var containerPDFView: UIView!
    @IBOutlet weak var documentPictureImageView: UIImageView!
    
    var presenter: DocumentPresenter?
    
    override func didLoad() {
        super.didLoad()
        self.validateUser()
        self.setupBody()
    }
    
}

extension DocumentView {
    
    private func setupBody() {
        setupView()
        setupAction()
    }
    
    private func setupView() {
        guard let presenter else { return }
        self.customNavigationView.configure(toolbarTitle: presenter.type == .pdf ? "Dokumen" : "", type: presenter.type == .pdf ? .toolbar : .plain, actionTitle: "Unduh")
        switch presenter.type {
        case .image:
            self.documentPictureImageView.isHidden = false
            self.documentPictureImageView.loadImageUrl(presenter.file ?? "")
        case .pdf:
            self.containerPDFView.isHidden = false
            setupPDFView(file: presenter.file ?? "")
        default:
            break
        }
        
    }
    
    private func setupAction() {
        guard let presenter else { return }
        customNavigationView.arrowLeftBackButton.gesture()
            .sink { [weak self] _ in
                guard let self,
                      let navigation = self.navigationController
                else { return }
                navigation.popViewController(animated: true)
            }
            .store(in: &anyCancellable)
        
        customNavigationView.actionLabel.gesture()
            .sink { [weak self] _ in
                guard let self else { return }
                self.downloadFile(from: presenter.file ?? "")
            }
            .store(in: &anyCancellable)
    }
    
    private func downloadFile(from url: String) {
        guard let fileURL = URL(string: url) else { return }
        
        let task = URLSession.shared.downloadTask(with: fileURL) { localURL, response, error in
            guard let localURL = localURL, error == nil else { return }
            
            do {
                let documentsURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                let savedURL = documentsURL.appendingPathComponent(localURL.lastPathComponent)
                try FileManager.default.moveItem(at: localURL, to: savedURL)
                
                DispatchQueue.main.async {
                    self.showAlert(title: "Pemberitahuan", message: "Dokumen berhasil tersimpan")
                }
            } catch {
                AppLogger.log("File error: \(error)")
            }
        }
        task.resume()
    }
    
    private func setupPDFView(file: String) {
        guard let pdfURL = URL(string: file) else { return }
        let pdfView = PDFView(frame: self.containerPDFView.bounds)
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        self.containerPDFView.addSubview(pdfView)
        
        NSLayoutConstraint.activate([
            pdfView.leadingAnchor.constraint(equalTo: self.containerPDFView.leadingAnchor),
            pdfView.trailingAnchor.constraint(equalTo: self.containerPDFView.trailingAnchor),
            pdfView.topAnchor.constraint(equalTo: self.containerPDFView.topAnchor),
            pdfView.bottomAnchor.constraint(equalTo: self.containerPDFView.bottomAnchor)
        ])
        
        if let pdfDocument = PDFDocument(url: pdfURL) {
            pdfView.document = pdfDocument
        }
    }
    
}
