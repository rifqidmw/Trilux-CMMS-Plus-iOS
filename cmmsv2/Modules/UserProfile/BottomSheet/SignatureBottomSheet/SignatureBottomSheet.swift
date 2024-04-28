//
//  SignatureBottomSheet.swift
//  cmmsv2
//
//  Created by PRO M1 2020 8/256 on 28/04/24.
//

import UIKit
import Combine

class SignatureBottomSheet: BaseNonNavigationController {
    
    @IBOutlet weak var dismissAreaView: UIView!
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    @IBOutlet weak var cameraButton: UIImageView!
    @IBOutlet weak var signaturePadView: UIView!
    @IBOutlet weak var clearButton: GeneralButton!
    @IBOutlet weak var saveButton: GeneralButton!
    
    var signaturePath: UIBezierPath?
    var signatureString: String?
    
    override func didLoad() {
        super.didLoad()
        self.setupBody()
    }
    
}

extension SignatureBottomSheet {
    
    private func setupBody() {
        setupView()
        setupAction()
        setupSignaturePad()
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
            self.dismiss(animated: true)
        }
        .store(in: &anyCancellable)
        
        clearButton.gesture()
            .sink { [weak self] _ in
                guard let self else { return }
                self.clearSignatureCanvas()
            }
            .store(in: &anyCancellable)
        
        saveButton.gesture()
            .sink { [weak self] _ in
                guard let self else { return }
                guard let base64Signature = convertSignatureToBase64String() else {
                    print("Failed to convert signature to base64 string")
                    return
                }
                self.signatureString = base64Signature
                print("Signature converted to base64 string:", base64Signature)
            }.store(in: &anyCancellable)
    }
    
}

extension SignatureBottomSheet {
    
    private func clearSignatureCanvas() {
        signaturePath = nil
        signaturePadView.layer.sublayers?.removeAll()
    }
    
    private func convertSignatureToBase64String() -> String? {
        guard let signatureImage = captureSignatureImage() else { return nil }
        guard let imageData = signatureImage.jpegData(compressionQuality: 1.0) else { return nil }
        return imageData.base64EncodedString()
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
        path.lineWidth = 2.0
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
        return shapeLayer
    }
    
}
