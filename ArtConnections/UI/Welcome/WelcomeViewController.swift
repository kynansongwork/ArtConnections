//
//  WelcomeViewController.swift
//  ArtConnections
//
//  Created by Kynan Song on 08/10/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import UIKit
import FirebaseAuth

class WelcomeViewController: UIViewController, StoryboardLoadedViewController {
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func welcomeButtonTapped(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            viewModel.coordinator?.transition(BaseTransitionRef.SignedIn)
        } else {
            viewModel.coordinator?.transition(BaseTransitionRef.Login)
        }
        
    }
}
