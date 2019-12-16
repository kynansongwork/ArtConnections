//
//  LoginViewModel.swift
//  ArtConnections
//
//  Created by Kynan Song on 07/10/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import Foundation

class LoginViewModel: ViewModel {
    
    let validator = ValidationManager()
    
    func validateEmail(_ email: String) -> Bool {
        return validator.isValidEmail(emailString: email)
    }
    
}
