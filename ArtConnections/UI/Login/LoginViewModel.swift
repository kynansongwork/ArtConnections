//
//  LoginViewModel.swift
//  ArtConnections
//
//  Created by Kynan Song on 07/10/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import Foundation
import FirebaseAuth

class LoginViewModel: ViewModel {
    
    let validator = ValidationManager()
    
    func validateEmail(_ email: String) -> Bool {
        return validator.isValidEmail(emailString: email)
    }
    
    func signIn(email: String, password: String) {
        
        let cleanEmail = email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let cleanPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        Auth.auth().signIn(withEmail: cleanEmail, password: cleanPassword, completion: {
            (result, error) in
            
            if error != nil {
                //Need to add label or alert to surface error
                print("Sign in error: \(error?.localizedDescription)")
            } else {
                print("User signed in")
                self.coordinator?.transition(LoginRef.Profile)
            }
        })
    }
    
}
