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
        let imageData = self.pngData()
        
        if let strBase64 = imageData?.base64EncodedString(options: .lineLength64Characters) {
          return strBase64
        }
        return ""
    }
}
