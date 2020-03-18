//
//  UIAlertExtensions.swift
//  ArtConnections
//
//  Created by Kynan Song on 14/01/2020.
//  Copyright © 2020 scottishAsian. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    func presentInOwnWindow(animated: Bool, completion: (() -> Void)?) {
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindow.Level.alert + 1;
        alertWindow.makeKeyAndVisible()
        
        DispatchQueue.main.async {
            alertWindow.rootViewController?.present(self, animated: animated, completion: nil)
        }
    }
}
