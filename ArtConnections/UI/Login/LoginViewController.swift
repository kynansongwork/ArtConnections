//
//  LoginViewController.swift
//  ArtConnections
//
//  Created by Kynan Song on 29/09/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, StoryboardLoadedViewController {
    
    var viewModel: LoginViewModel!
    
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
}
