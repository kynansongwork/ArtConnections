//
//  ValidationManager.swift
//  ArtConnections
//
//  Created by Kynan Song on 15/10/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import Foundation

class ValidationManager {
    
    func isValidEmail(emailString: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailString)
    }
    
    func isStrongPassword(passwordString: String) -> Bool {
        return true
    }
}
