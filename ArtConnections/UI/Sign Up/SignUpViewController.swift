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
        continueButton.isEnabled = false
        emailTextField.delegate = self
        [emailTextField, nameTextField, specialtyTextField].forEach( {$0?.addTarget(self, action: #selector(continueButtonIsEnabled), for: .editingChanged)} )
    }
    
    @objc func continueButtonIsEnabled(_ textField: UITextField) {
        if var text = textField.text {
            if text.first == " " {
                text = ""
                return
            }
        }
        guard
            let email = emailTextField.text, !email.isEmpty,
            let name = nameTextField.text, !name.isEmpty,
            let specialty = specialtyTextField.text, !specialty.isEmpty
        else {
            continueButton.isEnabled = false
            return
        }
        
        if viewModel.validateEmail(email) {
           continueButton.isEnabled = true
        } else {
            continueButton.isEnabled = false
        }
    }
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        viewModel.saveData()
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
                print("email is valid")
            } else {
                print("email is not valid")
            }
        }
    }
}
