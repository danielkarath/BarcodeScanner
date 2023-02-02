//
//  BSScanStateLabelView.swift
//  BarcodeScanner
//
//  Created by Daniel Karath on 2/2/23.
//

import SwiftUI
import UniformTypeIdentifiers

struct BSScanStateLabelView: View {
    var titleText: String
    var body: some View {
        Text(titleText)
            //.frame(maxWidth: UIScreen.main.bounds.width-150, maxHeight: 30, alignment: .leading)
            .font(.system(size: BSConstants.shared.largeFontSize)).bold()
            .foregroundColor(titleText == "Not Yet Scanned" ? .gray : .white)
            .padding()
            .onTapGesture(count: 2) {
                if titleText != "Not Yet Scanned" {
                    UIPasteboard.general.setValue(titleText,
                                                  forPasteboardType: UTType.plainText.identifier)
                }
            }
    }
}

struct BSScanStateLabelView_Previews: PreviewProvider {
    static var previews: some View {
        BSScanStateLabelView(titleText: "Not Yet Scanned")
    }
}
