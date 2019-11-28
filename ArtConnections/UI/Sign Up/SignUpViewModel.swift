//
//  SignUpViewModel.swift
//  ArtConnections
//
//  Created by Kynan Song on 09/10/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import Foundation
import UIKit

class SignUpViewModel: ViewModel {
    
    //May put this in credentials service wrapper
    let cognitoService: CognitoService
    let validator = ValidationManager()
    var initialPassword: String?
    
    init(cognitoService: CognitoService) {
        self.cognitoService = cognitoService
        super.init()
    }
    
    func validateEmail(_ email: String) -> Bool {
        return validator.isValidEmail(emailString: email)
    }
    
    func validatePassword(_ passwordString: String, _ infoLabel: UILabel!) -> Bool {
        return validator.isStrongPassword(passwordString, infoLabel)
    }
    
    func saveData(email: String, name: String, specialty: String, password: String) {
        //save and send data
        
        //save to user defaults
        let dataFetcher = DataFetcher()
        let userObject = UserObject(email: email, name: name, specialty: specialty, password: password)
        dataFetcher.encodeData(userData: userObject)
        
        //save to cognito - move to next viewModel
        cognitoService.signUp(email: email, name: name, specialty: specialty, password: password, completion: {(success, user, error) in
            if success {
                print("Success")
            } else {
                if let error = error, case CognitoError.userAlreadyExists = error {
                    print("User already exists")
                }
            }
        })
        
        //Move to success when cognito set up
        coordinator?.transition(SignUpRef.AdditionalDetails, object: userObject)
    }
    
    func completeSignUp() {
        //save to cognito
//        cognitoService.signUp(email: email, name: name, specialty: specialty, password: password, completion: {(success, user, error) in
//            if success {
//                print("Success")
//            } else {
//                if let error = error, case CognitoError.userAlreadyExists = error {
//                    print("User already exists")
//                }
//            }
//        })
    }
}
