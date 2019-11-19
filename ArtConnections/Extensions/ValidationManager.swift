//
//  ValidationManager.swift
//  ArtConnections
//
//  Created by Kynan Song on 15/10/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import Foundation
import UIKit

class ValidationManager {
    
    func isValidEmail(emailString: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailString)
    }
    
    func isStrongPassword(_ password: String, _ infoLabel: UILabel!) -> Bool {
        
        let passwordInfoString = NSMutableAttributedString(string: "Your password must be at least 8 characters, and contain at least one upper case letter, one lower case letter and a number.", attributes: [
            .font: UIFont.init(name: "Roboto", size: 11.0) ?? UIFont.systemFont(ofSize: 11.0),
            .foregroundColor: UIColor.red
        ])
        
        passwordInfoString.addAttributes(setUpAttributeColour(if: (password.count >= 8)),
        range: findRange(in: passwordInfoString.string, for: "at least 8 characters"))
        
        passwordInfoString.addAttributes(setUpAttributeColour(if: (password.rangeOfCharacter(from: CharacterSet.uppercaseLetters) != nil)),
        range: findRange(in: passwordInfoString.string, for: "one upper case letter"))
        
        passwordInfoString.addAttributes(setUpAttributeColour(if: (password.rangeOfCharacter(from: CharacterSet.lowercaseLetters) != nil)),
        range: findRange(in: passwordInfoString.string, for: "one lower case letter"))
        
        passwordInfoString.addAttributes(setUpAttributeColour(if: (password.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil)),
        range: findRange(in: passwordInfoString.string, for: "a number"))
        
        infoLabel.attributedText = passwordInfoString
        
        if password.count >= 8, (password.rangeOfCharacter(from: CharacterSet.uppercaseLetters) != nil), (password.rangeOfCharacter(from: CharacterSet.lowercaseLetters) != nil), (password.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil) {
            return true
        } else {
            return false
        }
    }
    
    func setUpAttributeColour(if isValid: Bool) -> [NSAttributedString.Key: Any] {
        if isValid {
            return [NSAttributedString.Key.foregroundColor: UIColor.blue]
        } else {
            return [NSAttributedString.Key.foregroundColor: UIColor.red]
        }
    }
    
    func findRange(in baseString: String, for subString: String) -> NSRange {
        if let range = baseString.localizedStandardRange(of: subString) {
            let startIndex = baseString.distance(from: baseString.startIndex, to: range.lowerBound)
            let stringLength = subString.count
            return NSMakeRange(startIndex, stringLength)
        } else {
            //Put error here
            return NSMakeRange(0, 0)
        }
    }

    //Password validation: https://medium.com/jen-hamilton/swift-4-password-validation-helper-methods-f98a7ea5dcbb
}
