//
//  UserPool.swift
//  ArtConnections
//
//  Created by Kynan Song on 18/11/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import Foundation
import AWSCognitoIdentityProvider

class UserPool {
    
    //var pool: AWSCognitoMockUserPoolProtocol!
    var pool: AWSCognitoIdentityUserPool?
    var poolID = "us-east-2_3CFmLe5Ol"
    var appClientID = "1hmea598pku3nlrdvkstnuo1n8"
    var appClientSecret = "qbu5ti55m8o93gsk5dsu1rthsck19kbrdnfepqovm2gqcokor5o"
    
    init() {
        let serviceConfiguration = AWSServiceConfiguration(region: .USEast2, credentialsProvider: nil)
        let poolConfiguration = AWSCognitoIdentityUserPoolConfiguration(clientId: appClientID, clientSecret: appClientSecret, poolId: poolID)
        AWSCognitoIdentityUserPool.register(with: serviceConfiguration, userPoolConfiguration: poolConfiguration, forKey: "UserPool")
        pool = AWSCognitoIdentityUserPool(forKey: "UserPool")
    }
    
//    var currentUser: AWSCognitoMockUserProtocol? {
//        return pool.currentUser()
//       }
//
//    func getUser(_ username: String) -> AWSCognitoMockUserProtocol {
//        return pool.getUser(username)
//    }
}
