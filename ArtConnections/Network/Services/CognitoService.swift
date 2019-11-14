//
//  CognitoService.swift
//  ArtConnections
//
//  Created by Kynan Song on 14/11/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import Foundation
import AWSCognitoIdentityProvider

enum CognitoError {
    case userAlreadyExists
    case userDoesNotExist
    case resetPinDoesNotMatch
    case failedToFetchUserSub
    case unknown(error: Error)
}

class CognitoService: NSObject {
    
    var pool: AWSCognitoIdentityUserPool?
    
    func signUp(email: String, name: String, specialty: String, password: String, completion: @escaping (Bool, AWSCognitoIdentityUser?, _ error: CognitoError?) -> Void) {
        
        let nameValue = AWSCognitoIdentityUserAttributeType(name: "name", value: name)
        let specialtyValue = AWSCognitoIdentityUserAttributeType(name: "specialty", value: specialty)
        
        self.pool?.signUp(email, password: password, userAttributes: [nameValue, specialtyValue], validationData: nil).continueWith {
            (response) -> Any? in
            guard response.error == nil, response.result != nil else {
                print("Error: \(response.error)")
                DispatchQueue.main.async {
                    completion(false, nil, self.convertToCognitoError(response.error!))
                }
                return nil
            }
            return nil
        }
    }
    
    private func convertToCognitoError(_ error: Error) -> CognitoError {
           if let type = (error as NSError).userInfo["__type"] as? String {
               switch type {
               case "UsernameExistsException", "UserLambdaValidationException":
                   return .userAlreadyExists
               case "CodeMismatchException":
                   return .resetPinDoesNotMatch
               case "UserNotFoundException" :
                   return .userDoesNotExist
               default:
                   break
               }
           }
           return .unknown(error: error)
       }
}
