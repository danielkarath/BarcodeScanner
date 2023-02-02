//
//  BSCopyButtonView.swift
//  BarcodeScanner
//
//  Created by Daniel Karath on 2/2/23.
//

import SwiftUI
import UniformTypeIdentifiers

struct BSCopyButtonView: View {
    
    var barcodeString: String
    
    var body: some View {
        Button(action: {
            UIPasteboard.general.setValue(barcodeString,
                                          forPasteboardType: UTType.plainText.identifier)
        }) {
            Image(systemName: "clipboard.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24, alignment: .center)
                .foregroundColor(.white)
        }
        .frame(width: 35, height: 35, alignment: .center)
        .background(Color.blue)
        .cornerRadius(8)
        .opacity(barcodeString.isEmpty ? 0 : 1)
    }
}

struct BSCopyButtonView_Previews: PreviewProvider {
    static var previews: some View {
        BSCopyButtonView(barcodeString: "0123456789")
    }
}
