//
//  DataFetcher.swift
//  ArtConnections
//
//  Created by Kynan Song on 11/11/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import Foundation

class DataFetcher {
    
    let defaults = UserDefaults.standard
    
    func encodeData(userData: UserObject) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(userData) {
            defaults.set(encoded, forKey: "artUser")
            print(decodeData())
        }
    }
    
    func decodeData() -> UserObject {
        
        var returningUser: UserObject?
        
        if let savedUser = defaults.object(forKey: "artUser") as? Data {
            let decoder = JSONDecoder()
            if let loadedUser = try? decoder.decode(UserObject.self, from: savedUser) {
                returningUser = loadedUser
            }
        }
        
        return returningUser!
    }
}
