//
//  AdditionalDetailsViewModel.swift
//  ArtConnections
//
//  Created by Kynan Song on 25/11/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class AdditionalDetailsViewModel: ViewModel {
    
    var userObject: UserObject
    var profileImage = UIImage(named: "placeHolderImage")
    
    required init(coordinator: BaseCoordinator, userObject: UserObject) {
        self.userObject = userObject
        super.init(coordinator: coordinator)
    }
    
    func saveUserDetails(profile: String, website: String, image: UIImage) {
        
        Auth.auth().createUser(withEmail: userObject.email, password: userObject.password) { (result, error) in
            
            //Errors
            if let error = error {
                //Show alert here
                print("There was an error creating the user: \(error.localizedDescription)")
            } else {
                let database = Firestore.firestore()
                let userId = Auth.auth().currentUser?.uid
                
                if let id = userId {
                    database.collection("users").document(id).setData([
                        "name": self.userObject.name,
                        "profileImage": "Image String here",
                        "profileInfo": profile,
                        "specialty": self.userObject.specialty,
                        "website": website,
                        "uid": result!.user.uid
                    ])
                    self.coordinator?.present(ProfileCoordinator())
                } else {
                    print("Error creating document")
                }
            }
        }
    }
    
}
