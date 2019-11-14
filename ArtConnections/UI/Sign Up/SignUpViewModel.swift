//
//  SignUpViewModel.swift
//  ArtConnections
//
//  Created by Kynan Song on 09/10/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import Foundation

class SignUpViewModel: ViewModel {
    
//    let cognitoService: CognitoService
//    
//    init(cognitoService: CognitoService) {
//        self.cognitoService = cognitoService
//    }
//    
    func validateEmail(_ email: String) -> Bool {
        let validator = ValidationManager()
        
        return validator.isValidEmail(emailString: email)
    }
    
    func saveData(email: String, name: String, specialty: String) {
        //save and send data
        let dataFetcher = DataFetcher()
        let userObject = UserObject(email: email, name: name, specialty: specialty)
        dataFetcher.encodeData(userData: userObject)
        
        //save to cognito
//        let userId = UUID()
//        let pin = "1234"
//        cognitoService.signUp(userId: userId, email: email, name: name, specialty: specialty, pin: pin, completion: {(success, user, error) in
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
