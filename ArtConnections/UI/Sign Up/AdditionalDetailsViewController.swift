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
    }
    
    @IBAction func completeSignUpTapped(_ sender: Any) {
        //viewModel.saveUserDetails(profile: <#T##String#>, website: <#T##URL#>, image: <#T##UIImage#>)
        print("Save data here")
    }
    
    
}


