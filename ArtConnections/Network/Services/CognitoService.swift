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

//Investigate using firebase as an alternative to Cognito
//https://www.youtube.com/watch?v=uO9OqS1hdoE

class CognitoService: NSObject {
    
    var pool: AWSCognitoIdentityUserPool?
    var userPool: UserPool
    
    override init() {
        self.userPool = UserPool()
        super.init()
    }
    
    init(withUserPool userPool: UserPool) {
        self.userPool = userPool
        super.init()
    }
    
    func getUser(withEmail: String) -> AWSCognitoIdentityUser {
        if let userSource = userPool.pool {
            return userSource.getUser(withEmail)
        }
        return AWSCognitoIdentityUser()
    }
    
    func signUp(email: String, name: String, specialty: String, password: String, completion: @escaping (Bool, AWSCognitoIdentityUser?, _ error: CognitoError?) -> Void) {
        
        let nameValue = AWSCognitoIdentityUserAttributeType(name: "name", value: name)
        let specialtyValue = AWSCognitoIdentityUserAttributeType(name: "custom:custom:specialty", value: specialty)
        
        userPool.pool?.signUp(email, password: password, userAttributes: [nameValue, specialtyValue], validationData: nil).continueWith {
            (response) -> Any? in
            guard response.error == nil, response.result != nil else {
                print("Error: \(response.error)")
                DispatchQueue.main.async {
                    completion(false, nil, self.convertToCognitoError(response.error!))
                }
                print(response.result)
                return nil
            }
            
            DispatchQueue.main.async {
                completion(true, response.result?.user, nil)
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
