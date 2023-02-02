//
//  BSBarcodeLabelView.swift
//  BarcodeScanner
//
//  Created by Daniel Karath on 2/2/23.
//

import SwiftUI

struct BSBarcodeLabelView: View {
    var body: some View {
        Label("Scanned Barcode:", systemImage: "barcode.viewfinder")
            .frame(alignment: .leading)
            .font(.headline)
            .foregroundColor(Color.gray)
            .padding()
    }
}

struct BSBarcodeLabelView_Previews: PreviewProvider {
    static var previews: some View {
        BSBarcodeLabelView()
    }
}
