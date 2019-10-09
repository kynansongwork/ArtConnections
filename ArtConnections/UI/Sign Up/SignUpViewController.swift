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
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var specialtyTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        continueButtonIsEnabled()
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
