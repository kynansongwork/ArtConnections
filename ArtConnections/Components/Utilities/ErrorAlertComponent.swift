//
//  ErrorAlertComponent.swift
//  ArtConnections
//
//  Created by Kynan Song on 30/12/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import Foundation
import UIKit

struct ErrorAlert {
    var title: String
    var description: String
    var primaryButton: ErrorButton
    var secondaryButton: ErrorButton
}

struct ErrorButton {
    let title: String
    let target: AnyObject?
    let selector: Selector?
}

//Implement custom error alert at later point.
