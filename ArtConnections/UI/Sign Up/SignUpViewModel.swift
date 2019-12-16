//
//  SignUpViewModel.swift
//  ArtConnections
//
//  Created by Kynan Song on 09/10/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import Foundation
import UIKit
import Firebase

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
        
        //strip out whitespace
        let userObject = UserObject(email: email, name: name, specialty: specialty)
        
        let cleanEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().createUser(withEmail: cleanEmail, password: cleanPassword) { (result, error) in
            
            //Errors
            if let error = error {
                print("There was an error creating the user: \(error.localizedDescription)")
            } else {
                let database = Firestore.firestore()
                var reference: DocumentReference? = nil
                
                reference = database.collection("users").addDocument(data: [
                    "profileImage": "",
                    "profileInfo": "",
                    "specialty": specialty,
                    "website": "",
                    "uid": result!.user.uid
                ], completion: { (error) in
                    if error != nil {
                        print("Userdata error when saving to database: \(error?.localizedDescription)")
                    }
                })
                self.coordinator?.transition(SignUpRef.AdditionalDetails, object: userObject)
            }
        }
    }
}
