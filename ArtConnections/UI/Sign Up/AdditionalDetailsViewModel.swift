//
//  AdditionalDetailsViewModel.swift
//  ArtConnections
//
//  Created by Kynan Song on 25/11/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import Foundation
import UIKit

class AdditionalDetailsViewModel: ViewModel {
    
    var password: String?
    
    init(password: String) {
        self.password = password
        super.init()
    }
    
}
