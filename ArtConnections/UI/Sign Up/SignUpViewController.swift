//
//  SignUpViewController.swift
//  ArtConnections
//
//  Created by Kynan Song on 09/10/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController, StoryboardLoadedViewController {
    var viewModel: SignUpViewModel!
    var delegate = self
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var specialtyTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        continueButtonIsEnabled()
        emailTextField.delegate = self
        //https://stackoverflow.com/questions/34941069/enable-a-button-in-swift-only-if-all-text-fields-have-been-filled-out
    }
    
    func continueButtonIsEnabled() {
        if emailTextField.text?.isEmpty == true || nameTextField.text?.isEmpty == true || specialtyTextField.text?.isEmpty == true {
            continueButton.isEnabled = false
        } else {
            continueButton.isEnabled = true
        }
    }
    
    @IBAction func continueButtonTapped(_ sender: Any) {
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let validEmail = emailTextField.text {
            if viewModel.validateEmail(validEmail) {
                print("valid email")
                return true
            } else {
                print("email is invalid")
                return false
            }
        }
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let emailText = textField.text {
            if viewModel.validateEmail(emailText) {
                print("emai is valid")
            } else {
                print("email is not valid")
            }
        }
    }
}
