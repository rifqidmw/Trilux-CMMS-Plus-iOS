//
//  SignatureBottomSheet.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 28/04/24.
//

import UIKit
import Combine
import Photos

protocol SignatureBottomSheetDelegate: AnyObject {
    func didTapSaveSignature(signature: Data, view: SignatureBottomSheet)
    func didTapCameraButton()
}

class SignatureBottomSheet: BaseNonNavigationController {
    
    @IBOutlet weak var dismissAreaView: UIView!
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    @IBOutlet weak var cameraButton: UIImageView!
    @IBOutlet weak var signaturePadView: UIView!
    @IBOutlet weak var signatureImageView: UIImageView!
    @IBOutlet weak var clearButton: GeneralButton!
    @IBOutlet weak var saveButton: GeneralButton!
    
    weak var delegate: SignatureBottomSheetDelegate?
    var data: User?
    var signaturePath: UIBezierPath?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
        self.showBottomSheet()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadUserSignature()
    }
    
}

extension SignatureBottomSheet {
    
    private func setupBody() {
        setupView()
        setupAction()
        setupSignaturePad()
        loadUserSignature()
    }
    
    private func setupView() {
        clearButton.configure(title: "Hapus", type: .bordered)
        saveButton.configure(title: "Simpan")
    }
    
    private func setupAction() {
        Publishers.Merge(
            bottomSheetView.handleBarArea.gesture(),
            dismissAreaView.gesture())
        .sink { [weak self] _ in
            guard let self else { return }
            self.dismissBottomSheet()
        }
        .store(in: &anyCancellable)
        
        clearButton.gesture()
            .sink { [weak self] _ in
                guard let self else { return }
                self.signatureImageView.isHidden = true
                self.signaturePadView.isHidden = false
                self.clearSignatureCanvas()
            }
            .store(in: &anyCancellable)
        
        saveButton.gesture()
            .sink { [weak self] _ in
                guard let self = self else { return }
                guard let signatureImage = self.captureSignatureImage() else {
                    print("Failed to capture signature image")
                    return
                }
                
                guard let imageData = signatureImage.jpegData(compressionQuality: 1.0) else {
                    print("Failed to convert signature image to data")
                    return
                }
                
                self.delegate?.didTapSaveSignature(signature: imageData, view: self)
            }
            .store(in: &anyCancellable)
        
        cameraButton.gesture()
            .sink { [weak self] _ in
                guard let self else { return }
                self.delegate?.didTapCameraButton()
            }
            .store(in: &anyCancellable)
    }
    
}

extension SignatureBottomSheet {
    
    private func loadUserSignature() {
        guard let data = self.data,
              let userSignature = data.ttd,
              let signatureImage = UIImage(base64String: userSignature)
        else { return }
        self.signatureImageView.image = signatureImage
    }
    
    private func clearSignatureCanvas() {
        signaturePath = nil
        signaturePadView.layer.sublayers?.removeAll()
    }
    
    private func captureSignatureImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(signaturePadView.bounds.size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        signaturePadView.layer.render(in: context)
        let signatureImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return signatureImage
    }
    
    private func setupSignaturePad() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        signaturePadView.addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        let location = recognizer.location(in: signaturePadView)
        
        switch recognizer.state {
        case .began:
            if signaturePadView.bounds.contains(location) {
                startDrawing(at: location)
            }
        case .changed:
            if signaturePadView.bounds.contains(location) {
                continueDrawing(at: location)
            }
        default:
            break
        }
    }
    
    private func startDrawing(at point: CGPoint) {
        let path = UIBezierPath()
        path.lineCapStyle = .round
        path.move(to: point)
        
        signaturePath = path
        signaturePadView.layer.sublayers?.removeAll()
        signaturePadView.layer.addSublayer(createShapeLayer(with: path))
    }
    
    private func continueDrawing(at point: CGPoint) {
        guard let path = signaturePath else { return }
        
        path.addLine(to: point)
        
        signaturePadView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        signaturePadView.layer.addSublayer(createShapeLayer(with: path))
    }
    
    private func createShapeLayer(with path: UIBezierPath) -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 4.0
        return shapeLayer
    }
    
}
