//
//  SignUpCoordinator.swift
//  ArtConnections
//
//  Created by Kynan Song on 20/11/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import Foundation
import UIKit

enum SignUpRef: TransitionRef {
    case AdditionalDetails
    case LogIn
}

class SignUpCoordinator: BaseCoordinator {
    
    let cognitoService: CognitoService
    
    required init () {
        cognitoService = CognitoService()
        let viewController = SignUpViewController.instantiateFromStoryBoard(storyboard: .Main, with: SignUpViewModel())
        super.init(rootViewController: viewController)
    }
    
    override func transition(_ transition: TransitionRef, object: Any? = nil) {
        guard let transition = transition as? SignUpRef else {
            return
        }
        
        switch transition {
        case .AdditionalDetails:
            showAdditionalDetails(userObject: object as! UserObject)
        case .LogIn:
            print("Logging in")
        default:
            break
        }
    }
}

extension SignUpCoordinator {

    func showAdditionalDetails(userObject: UserObject) {
        let controller = AdditionalDetailsViewController.instantiateFromStoryBoard(storyboard: .Main, with: AdditionalDetailsViewModel(coordinator: self, userObject: userObject))

        if #available(iOS 13, *) {
          controller.isModalInPresentation = true
        }
        
        self.show(controller)
    }
}
