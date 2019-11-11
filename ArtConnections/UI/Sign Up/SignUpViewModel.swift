//
//  SignUpViewModel.swift
//  ArtConnections
//
//  Created by Kynan Song on 09/10/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import Foundation

class SignUpViewModel: ViewModel {
    
    private(set) var userObject: UserObject?
    
    func validateEmail(_ email: String) -> Bool {
        let validator = ValidationManager()
        
        return validator.isValidEmail(emailString: email)
    }
    
    func saveData(email: String, name: String, specialty: String) {
        //save and send data
        userObject?.email = email
        userObject?.name = name
        userObject?.specialty = specialty
    }
}
