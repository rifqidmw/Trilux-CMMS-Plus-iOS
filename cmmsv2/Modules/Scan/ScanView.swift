//
//  ScanView.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 13/02/24.
//

import UIKit
import AVFoundation

class ScanView: BaseViewController {
    
    var presenter: ScanPresenter?
    
    var captureSession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var dataQR: QRProperties?
    weak var delegate: ScanViewDelegate?
    private var hasNavigated = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBody()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        videoPreviewLayer?.frame = view.layer.bounds
    }
    
}

extension ScanView {
    
    private func setupBody() {
        setupQRCode()
        bindingData()
    }
    
    private func setupQRCode() {
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {
            self.showAlert(title: "Perangkat Anda tidak mendukung pemindaian.")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(input)
            
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [.qr]
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = .resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            if let videoPreviewLayer = videoPreviewLayer {
                view.layer.addSublayer(videoPreviewLayer)
            }
            
            DispatchQueue.global(qos: .background).async {
                self.captureSession.startRunning()
            }
        } catch {
            self.showAlert(title: "Terjadi kesalahan!", message: error.localizedDescription)
        }
    }
    
    private func bindingData() {
        guard let presenter else { return }
        presenter.$detailEquipmentData
            .sink { [weak self] data in
                guard let self,
                      let navigation = self.navigationController,
                      let data = data,
                      let id = data.id,
                      let workSheet = presenter.data,
                      let request = presenter.request,
                      !self.hasNavigated
                else { return }
                self.hasNavigated = true
                self.captureSession.stopRunning()
                switch presenter.type {
                case .asset:
                    presenter.showBottomSheetDetailInformation(navigation: navigation, data: data)
                case .preventive:
                    if presenter.data?.idAsset != String(id) {
                        self.showAlert(title: "Peringatan", message: "Mohon scan alat yang sesuai")
                    } else {
                        presenter.navigateToLoadPreventive(navigation, data: workSheet)
                    }
                case .monitoring:
                    if presenter.data?.idAsset != String(id) {
                        self.showAlert(title: "Peringatan", message: "Mohon scan alat yang sesuai")
                    } else {
                        presenter.navigateToDetailWorkSheet(navigation, data: request, type: .monitoring, activity: .working, delegate: self)
                    }
                }
            }
            .store(in: &anyCancellable)
        
        presenter.$isError
            .sink { [weak self] isError in
                guard let self else { return }
                if isError {
                    self.showAlert(title: "Terjadi kesalahan!", message: "Gagal mendapatkan data, coba lagi!")
                }
            }
            .store(in: &anyCancellable)
        
        presenter.$isShowBottomSheet
            .sink { [weak self] isShow in
                guard let self else { return }
                DispatchQueue.global(qos: .background).async {
                    if isShow {
                        self.captureSession.stopRunning()
                    } else {
                        self.captureSession.startRunning()
                    }
                }
            }
            .store(in: &anyCancellable)
        
        presenter.$isLoading
            .sink { [weak self] isLoading in
                guard let self else { return }
                if isLoading {
                    self.showLoadingPopup()
                } else {
                    self.hideLoadingPopup()
                }
            }
            .store(in: &anyCancellable)
    }
    
}

extension ScanView: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
                  let stringValue = readableObject.stringValue,
                  let presenter = presenter
            else { return }
            
            do {
                let jsonData = Data(stringValue.utf8)
                let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: String]
                guard let id = json?["id"],
                      let coders = json?["coders"],
                      let codenom = json?["codenom"]
                else {
                    print("ID not found in QR code data")
                    return
                }
                
                let data = QRProperties(id: id, coders: coders, codenom: codenom)
                presenter.didScanQRCode(data)
            } catch {
                self.showAlert(title: "Terjadi kesalahan!", message: "Gagal melakukan dekode data, harap coba lagi.")
            }
        }
    }
}
