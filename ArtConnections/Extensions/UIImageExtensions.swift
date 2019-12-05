//
//  UIImageExtensions.swift
//  ArtConnections
//
//  Created by Kynan Song on 04/12/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    func convertImageToData() -> String {
        if let imageData = self.pngData() {
            let dataString = String(decoding: imageData, as: UTF8.self)
            return dataString
        }
        return ""
        
        
//        if let strBase64 = imageData?.base64EncodedString(options: .lineLength64Characters) {
//          return strBase64
//        }
//        return ""
        
    }
}
