//
//  LoginViewController.swift
//  ArtConnections
//
//  Created by Kynan Song on 29/09/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: KeyboardViewController, StoryboardLoadedViewController {
    
    var viewModel: LoginViewModel!
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var invalidEmailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        signInButton.isEnabled = false
        [emailTextField, passwordTextField].forEach( {$0?.addTarget(self, action: #selector(loginButtonIsEnabled), for: .editingChanged)} )

        invalidEmailLabel.text = Constants.SignInFlow.invalidEmail
        invalidEmailLabel.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        //Navigate to login flow
        viewModel.coordinator?.transition(LoginRef.Profile)
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        //Navigate to onboarding flow
        viewModel.coordinator?.transition(LoginRef.SignUp)
        //To fix nav animation.
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc func loginButtonIsEnabled(_ textField: UITextField) {
        if var text = textField.text {
            if text.first == " " {
                text = ""
                return
            }
        }
        guard
            let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty
        else {
            signInButton.isEnabled = false
            return
        }
        
        if viewModel.validateEmail(email) {
           signInButton.isEnabled = true
        } else {
           signInButton.isEnabled = false
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let validEmail = emailTextField.text {
            if viewModel.validateEmail(validEmail) {
                print("valid email")
                invalidEmailLabel.isHidden = true
                return true
            } else {
                print("email is invalid")
                invalidEmailLabel.isHidden = false
                return false
            }
        }
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let emailText = textField.text {
            if viewModel.validateEmail(emailText) {
                invalidEmailLabel.isHidden = true
            } else {
                invalidEmailLabel.isHidden = false
            }
        }
    }
}

//https://www.youtube.com/watch?v=1HN7usMROt8 - setting up firebase login
