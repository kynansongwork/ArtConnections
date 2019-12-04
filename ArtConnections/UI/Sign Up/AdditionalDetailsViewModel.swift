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
    
    let cognitoService: CognitoService
    var userObject: UserObject
    
    init(cognitoService: CognitoService, userObject: UserObject) {
        self.cognitoService = cognitoService
        self.userObject = userObject
        super.init()
    }
    
    func saveUserDetails(profile: String, website: String, image: UIImage) {
        
        //remove when S3 bucket set up
        let convertedImage = image.convertImageToData()
        
        //save to cognito - move to next viewModel
        cognitoService.signUp(email: userObject.email, name: userObject.name, specialty: userObject.specialty, password: userObject.password, profile: profile, website: website, image: convertedImage, completion: {(success, user, error) in
            if success {
                print("Success")
            } else {
                if let error = error, case CognitoError.userAlreadyExists = error {
                    print("User already exists")
                }
            }
        })
    }
    
}
