//
//  BSScannerViewController.swift
//  BarcodeScanner
//
//  Created by Daniel Karath on 2/2/23.
//

import Foundation
import UIKit
import AVFoundation

enum CameraError: String {
    case invalidDeviceInput = "Failled to access the device's camera."
    case invalidScanValue = "The value scanned is not valid. This app can scan EAN-8 and EAN-13."
}

protocol BSScannerViewControllerDelegate: AnyObject {
    func didRead(barcode: String)
    func didFailToReadBarcode(error: CameraError)
}

final class BSScannerViewController: UIViewController {
    
    let captureSession = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer?
    weak var scannerDelegate: BSScannerViewControllerDelegate?
    
    init(scannerDelegate: BSScannerViewControllerDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.scannerDelegate = scannerDelegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let previewLayer = previewLayer else {
            scannerDelegate?.didFailToReadBarcode(error: .invalidDeviceInput)
            return
        }
        previewLayer.frame = view.layer.bounds
    }
    
    private func setupCaptureSession() {
        print("Starting capture session")
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            scannerDelegate?.didFailToReadBarcode(error: .invalidDeviceInput)
            return
        }
        
        let videoInput: AVCaptureDeviceInput
        
        do {
            try videoInput = AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            scannerDelegate?.didFailToReadBarcode(error: .invalidDeviceInput)
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            scannerDelegate?.didFailToReadBarcode(error: .invalidDeviceInput)
        }
        
        let metaDataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metaDataOutput) {
            captureSession.addOutput(metaDataOutput)
            metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.global(qos: .background))
            metaDataOutput.metadataObjectTypes = [.ean8, .ean13]
        } else {
            scannerDelegate?.didFailToReadBarcode(error: .invalidDeviceInput)
        }
        
        if !captureSession.isRunning {
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer!.videoGravity = .resizeAspectFill
            view.layer.addSublayer(previewLayer!)
            DispatchQueue.global(qos: .background).async {
                self.captureSession.startRunning()
            }
        } else {
            scannerDelegate?.didFailToReadBarcode(error: .invalidDeviceInput)
        }
        
    }
    
    
}

extension BSScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let object = metadataObjects.first else {
            scannerDelegate?.didFailToReadBarcode(error: .invalidScanValue)
            return
        }
        guard let machineReadableObject = object as? AVMetadataMachineReadableCodeObject else {
            scannerDelegate?.didFailToReadBarcode(error: .invalidScanValue)
            return
        }
        guard let barcode = machineReadableObject.stringValue else {
            scannerDelegate?.didFailToReadBarcode(error: .invalidScanValue)
            return
        }
        if captureSession.isRunning {
            captureSession.stopRunning()
        }
        scannerDelegate?.didRead(barcode: barcode)
        
    }
    
}
