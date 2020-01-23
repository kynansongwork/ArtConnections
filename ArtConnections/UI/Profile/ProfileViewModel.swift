//
//  ProfileViewModel.swift
//  ArtConnections
//
//  Created by Kynan Song on 25/09/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import Foundation
import Firebase

class ProfileViewModel: ViewModel {
    
    let user = Auth.auth().currentUser
    let services = FirebaseServices()
    var name: String = "No name"
    var specialty: String = "No specialty"
    var profile: String = "No profile"
    var website: String = "No website"
    var imageUrl: URL?
    let firebaseService = FirebaseServices()
    
    override init() {
        super.init()
    }
    
    
    func getUserdetails() {
        let database = Firestore.firestore()
        
        if let userID = Auth.auth().currentUser?.uid {
            let documentTest = database.collection("users").document(userID)
            
            documentTest.getDocument(completion: { (document, error) in
                if let userDoc = document, userDoc.exists {
                    let data = userDoc.data().map(String.init(describing:)) ?? "nil data"
                    print("User data: \(data)")
                    
                    let profileData = document?.data()
                    
                    let profileImageString = profileData!["profileImage"]! as? String ?? "No name"
                    
                    self.name = profileData!["name"]! as? String ?? "No name"
                    self.specialty = profileData!["specialty"]! as? String ?? "No specialty"
                    self.profile = profileData!["profileInfo"]! as? String ?? "No name"
                    self.website = profileData!["website"]! as? String ?? "No name"
                    self.imageUrl = URL(string: profileImageString)
                    self.delegate?.viewModelDidUpdate()
                } else {
                    print("Document doesn't exist")
                }
            })
       }
    }
    
    func logOut() {
        if let coordinator = self.coordinator {
            firebaseService.logOut(coordinator: coordinator)
        }
    }
    
}
