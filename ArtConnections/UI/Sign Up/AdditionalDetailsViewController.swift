//
//  AdditionalDetailsViewController.swift
//  ArtConnections
//
//  Created by Kynan Song on 20/11/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import Foundation
import UIKit

class AdditionalDetailsViewController: KeyboardViewController, StoryboardLoadedViewController {
    
    var viewModel: AdditionalDetailsViewModel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var websiteTextField: UITextField!
    @IBOutlet weak var profileTextInputView: UITextView!
    @IBOutlet weak var completeSignUpButton: UIButton!
    
    override func viewDidLoad() {
        print(viewModel.userObject.email)
        setUpProfileImageView()
    }
    
    @IBAction func completeSignUpTapped(_ sender: Any) {
//        if let profileImage = profileImageView.image {
//          viewModel.saveUserDetails(profile: <#T##String#>, website: <#T##URL#>, image: profileImage)
//        }
        print("Save data here")
    }
    
    func setUpProfileImageView() {
        profileImageView.isUserInteractionEnabled = true
        let tapRecogniser = UITapGestureRecognizer(target: self, action: #selector(addProfileImage))
        profileImageView.addGestureRecognizer(tapRecogniser)
        
        if profileImageView.image == nil {
            profileImageView?.image = UIImage(named: "placeHolderImage.jpg")
        }
    }
    
    @objc func addProfileImage() {
        print("image view tapped")
        //Add camera method down the line
        selectImage(sourceType: .photoLibrary)
    }
}

extension AdditionalDetailsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func selectImage(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController =  UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = false
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImageView.contentMode = .scaleAspectFit
            profileImageView.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
        //Needed to dismiss image picker once an image is selected.
    }
}


