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
    
    func signUp(userId: UUID, email: String, name: String, specialty: String, pin: String, completion: @escaping (Bool, AWSCognitoIdentityUser?, _ error: CognitoError?) -> Void) {
        
    }
}
