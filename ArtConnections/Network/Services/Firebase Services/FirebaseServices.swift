//
//  FirebaseServices.swift
//  ArtConnections
//
//  Created by Kynan Song on 05/12/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import SwiftInstagram

class FirebaseServices {
    
    let instagramApi = Instagram.shared
    let storage = Storage.storage()
    
    func uploadImage(profile: String, website: String, userObject: UserObject, image: UIImage?, coordinator: BaseCoordinator) {
        
        guard let selectedImage = image, let uploadData = selectedImage.jpegData(compressionQuality: 1.0) else {
            print("Error")
            return
        }
        
        //if let user = Auth.auth().currentUser?.uid {
            let imageName = UUID().uuidString
        let imageReference = storage.reference().child(userObject.email + "/profileImages/" + imageName)
            let metaDataForImage = StorageMetadata()
            metaDataForImage.contentType = "image/jpeg"
            
            imageReference.putData(uploadData, metadata: metaDataForImage, completion: { (metadata, error) in
                
                if let error = error {
                    //add alert here
                    print("There was an error uploading \(error)")
                }
                
                guard let metaData = metadata else {
                    print("Error with the metadata")
                    return
                }
                
                imageReference.downloadURL { (url, error) in
                    if let error = error {
                        //add alert here
                        print("There was an error downloading \(error)")
                        coordinator.presentAlert(title: "Download error", message: "There was an error downloading \(error)")
                    }
                    
                    guard let downloadUrl = url else {
                        print("Error with the download url")
                        coordinator.presentAlert(title: "Download error", message: "Error with the download url")
                        return
                    }
                    
                    let imageURL = downloadUrl.absoluteString
                    
                    self.saveUserDetails(profile: profile, website: website, image: imageURL, userObject: userObject, coordinator: coordinator)
                }
            })
        //}
    }
    
    func saveUserDetails(profile: String, website: String, image: String, userObject: UserObject, coordinator: BaseCoordinator) {
            
        Auth.auth().createUser(withEmail: userObject.email, password: userObject.password) { (result, error) in
            
            //Errors
            if let error = error {
                //Show alert here
                print("There was an error creating the user: \(error.localizedDescription)")
                coordinator.presentAlert(title: "Creation error", message: "There was an error creating the user: \(error.localizedDescription)")
            } else {
                let database = Firestore.firestore()
                let userId = Auth.auth().currentUser?.uid
                
                if let id = userId {
                    database.collection("users").document(id).setData([
                        "name": userObject.name,
                        "profileImage": image,
                        "profileInfo": profile,
                        "specialty": userObject.specialty,
                        "website": website,
                        "uid": result!.user.uid
                    ])
                    coordinator.present(ProfileCoordinator())
                } else {
                    print("Error creating document")
                }
            }
        }
    }
    
    func logOut(coordinator: BaseCoordinator) {
        do {
            try Auth.auth().signOut()
            instagramApi.logout()
        } catch let logOutError {
            print("There was an issue logging out: \(logOutError)")
        }
        coordinator.dismiss()
    }
    
}
