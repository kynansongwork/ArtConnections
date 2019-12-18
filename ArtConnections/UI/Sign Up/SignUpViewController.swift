//
//  SignUpViewController.swift
//  ArtConnections
//
//  Created by Kynan Song on 09/10/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import Foundation
import UIKit

class SignUpViewController: KeyboardViewController, StoryboardLoadedViewController {
    var viewModel: SignUpViewModel!
    var delegate = self
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var specialtyTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var emailTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailNotValidLabel: UILabel!
    @IBOutlet weak var passwordInfoLabel: UILabel!
    
    override func viewDidLoad() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        //Need to add back button
        continueButton.isEnabled = false
        emailTextField.delegate = self
        [emailTextField, nameTextField, specialtyTextField, passwordTextField].forEach( {$0?.addTarget(self, action: #selector(continueButtonIsEnabled), for: .editingChanged)} )
        
        let tapRecogniser = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapRecogniser)
        
        passwordInfoLabel.attributedText = NSMutableAttributedString(string: "Your password must be at least 8 characters, and contain at least one upper case letter, one lower case letter and a number.", attributes: [
            .font: UIFont.init(name: "Roboto", size: 11.0) ?? UIFont.systemFont(ofSize: 11.0),
            .foregroundColor: UIColor.red
        ])
        
        emailNotValidLabel.text = Constants.SignInFlow.invalidEmail
        emailNotValidLabel.isHidden = true
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
            let specialty = specialtyTextField.text, !specialty.isEmpty,
            let password = passwordTextField.text, !password.isEmpty
        else {
            continueButton.isEnabled = false
            return
        }
        
        if viewModel.validateEmail(email) {
           continueButton.isEnabled = true
        } else {
            continueButton.isEnabled = false
        }
        
        if viewModel.validatePassword(password, passwordInfoLabel) {
            continueButton.isEnabled = true
        } else {
            continueButton.isEnabled = false
        }
    }
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        if let emailText = emailTextField.text, let nameText = nameTextField.text, let specialtyText = specialtyTextField.text, let passwordText = passwordTextField.text {
            viewModel.saveData(email: emailText, name: nameText, specialty: specialtyText, password: passwordText)
        }
        dismissKeyboard()
    }
    
    @objc override func dismissKeyboard() {
        emailTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
        specialtyTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let validEmail = emailTextField.text {
            if viewModel.validateEmail(validEmail) {
                print("valid email")
                emailNotValidLabel.isHidden = true
                return true
            } else {
                print("email is invalid")
                emailNotValidLabel.isHidden = false
                return false
            }
        }
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let emailText = textField.text {
            if viewModel.validateEmail(emailText) {
                emailNotValidLabel.isHidden = true
            } else {
                emailNotValidLabel.isHidden = false
            }
        }
    }
}
