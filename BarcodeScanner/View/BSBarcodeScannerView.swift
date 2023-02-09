//
//  BSBarcodeScannerView.swift
//  BarcodeScanner
//
//  Created by Daniel Karath on 2/2/23.
//

import SwiftUI

struct BSBarcodeScannerView: View {
    
    @State private var scannedCode: String = ""
    @State var alertItem: BSAlertItem?
    
    var body: some View {
        NavigationView {
            VStack {
                BSScannerView(scannedCode: $scannedCode, alertItem: $alertItem)
                    .frame(maxWidth: UIScreen.main.bounds.width-32, maxHeight: UIScreen.main.bounds.width-128)
                    //.background(Color.gray)
                Spacer().frame(height: 16)
                VStack(spacing: -20) {
                    HStack {
                        BSBarcodeLabelView()
                        Spacer()
                    }
                    HStack(spacing: -5) {
                        BSScanStateLabelView(titleText: scannedCode.isEmpty ? "Not Yet Scanned" : scannedCode)
                        BSCopyButtonView(barcodeString: scannedCode)
                        Spacer()
                    }
                }
                Spacer()
                if !scannedCode.isEmpty {
                    BSRestartButtonView(barcodeString: $scannedCode)
                        .padding(.bottom, 16)
                }
            }
            //.padding()
            .navigationTitle("Barcode Scanner")
            .colorScheme(.dark)
        }
    }
}

struct BSBarcodeScannerView_Previews: PreviewProvider {
    static var previews: some View {
        BSBarcodeScannerView()
    }
}

