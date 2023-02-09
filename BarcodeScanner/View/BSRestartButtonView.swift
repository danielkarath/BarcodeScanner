//
//  BSButtonView.swift
//  BarcodeScanner
//
//  Created by Daniel Karath on 2/2/23.
//

import SwiftUI

struct BSRestartButtonView: View {
    
    @Binding var barcodeString: String
    
    
    var body: some View {
        HStack(spacing: 20) {
            Button {
                barcodeString = ""
                print("restart button tapped")
            } label: {
                Text("Restart")
                    .frame(width: UIScreen.main.bounds.width-32, height: 18, alignment: .center)
                    .font(.system(size: BSConstants.shared.basicFontSize)).bold()
                    .foregroundColor(.white)
            }
            .frame(width: UIScreen.main.bounds.width-64, height: 60, alignment: .center)
            .background(Color.blue)
            .cornerRadius(8)
        }
    }
}

struct BSButtonView_Previews: PreviewProvider {
    static var previews: some View {
        BSRestartButtonView(barcodeString: .constant("1234456677434"))
    }
}
