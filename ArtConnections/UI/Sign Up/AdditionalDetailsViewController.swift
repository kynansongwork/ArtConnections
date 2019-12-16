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
        
        profileTextInputView.delegate = self
        
        let tapRecogniser = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapRecogniser)
        
        [websiteTextField].forEach( {$0?.addTarget(self, action: #selector(continueButtonIsEnabled), for: .editingChanged)} )
    }
    
    @objc func continueButtonIsEnabled(_ textField: UITextField) {
        if var text = textField.text {
            if text.first == " " {
                text = ""
                return
            }
        }
        guard
            let website = websiteTextField.text, !website.isEmpty
        else {
            self.completeSignUpButton.isEnabled = false
            return
        }
    }
    
    
    @IBAction func completeSignUpTapped(_ sender: Any) {
        if let profileImage = profileImageView.image, let profileText = profileTextInputView.text, let website = websiteTextField.text {
          viewModel.saveUserDetails(profile: profileText, website: website, image: profileImage)
        }
        print("Save data here")
        dismissKeyboard()
    }
    
    func setUpProfileImageView() {
        profileImageView.isUserInteractionEnabled = true
        let tapRecogniser = UITapGestureRecognizer(target: self, action: #selector(addProfileImage))
        profileImageView.addGestureRecognizer(tapRecogniser)
        
        if profileImageView.image == nil {
            profileImageView?.image = viewModel.profileImage
        }
    }
    
    @objc func addProfileImage() {
        print("image view tapped")
        //Add camera method down the line
        selectImage(sourceType: .photoLibrary)
    }
    
    @objc override func dismissKeyboard() {
        websiteTextField.resignFirstResponder()
        profileTextInputView.resignFirstResponder()
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

extension AdditionalDetailsViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if let websiteText = websiteTextField.text {
            if textView.text.isEmpty || websiteText.isEmpty {
                completeSignUpButton.isEnabled = false
            } else {
                completeSignUpButton.isEnabled = true
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if let websiteText = websiteTextField.text {
            if textView.text.isEmpty || websiteText.isEmpty {
                completeSignUpButton.isEnabled = false
            } else {
                completeSignUpButton.isEnabled = true
            }
        }
    }
}


