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
    let validator = ValidationManager()
    var initialPassword: String?
    
    override init() {
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
        
        //strip out whitespace
        
        
        let cleanEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        let userObject = UserObject(email: cleanEmail, name: name, specialty: specialty, password: cleanPassword)
        self.coordinator?.transition(SignUpRef.AdditionalDetails, object: userObject)
    }
}
