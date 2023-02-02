//
//  BSConstants.swift
//  BarcodeScanner
//
//  Created by Daniel Karath on 2/2/23.
//

import Foundation
import SwiftUI

final class BSConstants {
    
    static let shared = BSConstants()
    
    let basicFontSize: CGFloat = UIScreen.main.bounds.width/19
    let largeFontSize: CGFloat = UIScreen.main.bounds.width/15
    
    let emptyBackgroundColor: Color = Color(red: 18/255, green: 18/255, blue: 26/220)
}
