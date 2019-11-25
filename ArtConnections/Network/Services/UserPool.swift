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
    var poolID = "us-east-2_MdyRBx9vi"
    var appClientID = "3b2oe1g8sfh3kk3cj39v2jesm4"
    var appClientSecret = "1ilr882bau8i4m3r19h45p9cola5ct19r35ia8ake6aq84r7cuqr"
    
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
