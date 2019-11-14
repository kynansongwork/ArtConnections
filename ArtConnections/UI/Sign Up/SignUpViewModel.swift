//
//  SignUpViewModel.swift
//  ArtConnections
//
//  Created by Kynan Song on 09/10/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import Foundation

class SignUpViewModel: ViewModel {
    
    //May put this in credentials service wrapper
    let cognitoService: CognitoService
    
    init(cognitoService: CognitoService) {
        self.cognitoService = cognitoService
    }
    
    func validateEmail(_ email: String) -> Bool {
        let validator = ValidationManager()
        
        return validator.isValidEmail(emailString: email)
    }
    
    func validatePassword(_ password: String) -> Bool {
        return true
    }
    
    func saveData(email: String, name: String, specialty: String, password: String) {
        //save and send data
        
        //save to user defaults
        let dataFetcher = DataFetcher()
        let userObject = UserObject(email: email, name: name, specialty: specialty)
        dataFetcher.encodeData(userData: userObject)
        
        //save to cognito
        cognitoService.signUp(email: email, name: name, specialty: specialty, password: password, completion: {(success, user, error) in
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
