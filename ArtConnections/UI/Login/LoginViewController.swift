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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInButton.isEnabled = false
        [emailTextField, passwordTextField].forEach( {$0?.addTarget(self, action: #selector(loginButtonIsEnabled), for: .editingChanged)} )

        // Do any additional setup after loading the view.
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

//https://www.youtube.com/watch?v=1HN7usMROt8 - setting up firebase login
