//
//  AdditionalDetailsViewModel.swift
//  ArtConnections
//
//  Created by Kynan Song on 25/11/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class AdditionalDetailsViewModel: ViewModel {
    
    var userObject: UserObject
    var profileImage = UIImage(named: "placeHolderImage")
    let firebaseService = FirebaseServices()
    
    required init(coordinator: BaseCoordinator, userObject: UserObject) {
        self.userObject = userObject
        super.init(coordinator: coordinator)
    }
    
    func saveUserDetails(profile: String, website: String, image: UIImage, userObject: UserObject) {
        
        if let currentCoordinator = coordinator {
            firebaseService.uploadImage(profile: profile, website: website, userObject: userObject, image: image, coordinator: currentCoordinator)
        }
        
    }
    
}
