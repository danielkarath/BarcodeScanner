//
//  BSScannerView.swift
//  BarcodeScanner
//
//  Created by Daniel Karath on 2/2/23.
//

import SwiftUI

struct BSScannerView: UIViewControllerRepresentable {
    
    @Binding var scannedCode: String
    @Binding var alertItem: BSAlertItem?
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<BSScannerView>) -> BSScannerViewController {
        BSScannerViewController(scannerDelegate: context.coordinator)
    }
    
    func updateUIViewController(_ uiViewController: BSScannerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(scannerView: self)
    }
    
    final class Coordinator: NSObject, BSScannerViewControllerDelegate {
        
        private let scannerView: BSScannerView
        
        init(scannerView: BSScannerView) {
            self.scannerView = scannerView
        }
        
        func didRead(barcode: String) {
            scannerView.scannedCode = barcode
            print("barcode: \(barcode)")
        }
        
        func didFailToReadBarcode(error: CameraError) {
            switch error {
            case .invalidDeviceInput:
                scannerView.alertItem = BSAlertContext.invalidDeviceInput
            case .invalidScanValue:
                scannerView.alertItem = BSAlertContext.invalidScanType
            default:
                print("Error: \(error.rawValue)")
            }
        }
    }
}

/*
struct BSScannerView_Previews: PreviewProvider {
    static var previews: some View {
        BSScannerView()
    }
}
*/
