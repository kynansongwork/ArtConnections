//
//  SignUpViewModel.swift
//  ArtConnections
//
//  Created by Kynan Song on 09/10/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import Foundation

class SignUpViewModel: ViewModel {
    
    func validateEmail(_ email: String) -> Bool {
        let validator = ValidationManager()
        
        return validator.isValidEmail(emailString: email)
    }
    
    func saveData() {
        //save and send data
    }
}
