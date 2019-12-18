//
//  FirebaseServices.swift
//  ArtConnections
//
//  Created by Kynan Song on 05/12/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import Foundation
import FirebaseAuth

class FirebaseServices {
    
    func logOut(coordinator: BaseCoordinator) {
        do {
            try Auth.auth().signOut()
        } catch let logOutError {
            print("There was an issue logging out: \(logOutError)")
        }
        
        coordinator.present(AppCoordinator())
    }
    
}
