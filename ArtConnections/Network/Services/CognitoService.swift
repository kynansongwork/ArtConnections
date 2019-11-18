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

protocol AWSCognitoMockUserPoolProtocol {
    func currentUser() -> AWSCognitoIdentityUser?
    func getUser(_ username: String) -> AWSCognitoIdentityUser
    func signUp(_ username: String, password: String, userAttributes: [AWSCognitoIdentityUserAttributeType]?, validationData: [AWSCognitoIdentityUserAttributeType]?) -> AWSTask<AWSCognitoIdentityUserPoolSignUpResponse>
}

protocol AWSCognitoMockUserProtocol {
    var isSignedIn: Bool { get }
    var confirmedStatus: AWSCognitoIdentityUserStatus { get }

    func signOut()
    func getSession() -> AWSTask<AWSCognitoIdentityUserSession>
    func getSession(_ username: String, password: String, validationData: [AWSCognitoIdentityUserAttributeType]?) -> AWSTask<AWSCognitoIdentityUserSession>
    @discardableResult func forgotPassword() -> AWSTask<AWSCognitoIdentityUserForgotPasswordResponse>
    func confirmForgotPassword(_ code: String, password: String) -> AWSTask<AWSCognitoIdentityUserConfirmForgotPasswordResponse>
    @discardableResult func resendConfirmationCode() -> AWSTask<AWSCognitoIdentityUserResendConfirmationCodeResponse>
    func confirmSignUp(_ code: String) -> AWSTask<AWSCognitoIdentityUserConfirmSignUpResponse>
    func getDetails() -> AWSTask<AWSCognitoIdentityUserGetDetailsResponse>
    func changePassword(_ currentPassword: String, proposedPassword: String) -> AWSTask<AWSCognitoIdentityUserChangePasswordResponse>
    func delete() -> AWSTask<AnyObject>
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
