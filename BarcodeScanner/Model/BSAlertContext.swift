//
//  BSAlertContext.swift
//  BarcodeScanner
//
//  Created by Daniel Karath on 2/9/23.
//

import Foundation
import SwiftUI

struct BSAlertContext {
    static let invalidDeviceInput: BSAlertItem = BSAlertItem(title: "Invalid device input", message: "Failled to access the device's camera.", dismissButton: .default(Text("OK")))
    static let invalidScanType: BSAlertItem = BSAlertItem(title: "Invalid barcode format", message: "The value scanned is not valid. This app can scan EAN-8 and EAN-13.", dismissButton: .default(Text("OK")))
}
