//
//  LoginCoordinator.swift
//  ArtConnections
//
//  Created by Kynan Song on 25/09/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import Foundation
import UIKit

enum LoginRef: TransitionRef {
    case Login
    case Profile
    case SignUp
}

class LoginCoordinator: BaseCoordinator {
    
    let cognitoService: CognitoService
    
    required init () {
        let viewController = LoginViewController.instantiateFromStoryBoard(storyboard: .Main, with: LoginViewModel())
        cognitoService = CognitoService()
        super.init(rootViewController: viewController)
    }
    
    override func transition(_ transition: TransitionRef) {
        guard let transition = transition as? LoginRef else {
            return
        }
        
        switch transition {
        case .Profile:
            showProfilePage()
        case .SignUp:
            presentSignUpFlow()
        default:
            break
        }
    }
    
}

extension LoginCoordinator {
    
    func showProfilePage() {
        let controller = ProfileViewController.instantiateFromStoryBoard(storyboard: .Main, with: ProfileViewModel())

        if #available(iOS 13, *) {
          controller.isModalInPresentation = true
        }
        
        self.show(controller)
    }
    
    func presentSignUpFlow() {
        print("Sign Up")
        present(SignUpCoordinator())
    }
    
//    func showSignUpFlow() {
//        print("Sign Up")
//        let controller = SignUpViewController.instantiateFromStoryBoard(storyboard: .Main, with: SignUpViewModel(cognitoService: cognitoService))
//
//        if #available(iOS 13, *) {
//          controller.isModalInPresentation = true
//        }
//        
//        self.show(controller)
//    }
}
