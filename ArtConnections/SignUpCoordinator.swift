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
}

class SignUpCoordinator: BaseCoordinator {
    
    let cognitoService: CognitoService
    
    required init () {
        cognitoService = CognitoService()
        let viewController = SignUpViewController.instantiateFromStoryBoard(storyboard: .Main, with: SignUpViewModel(cognitoService: cognitoService))
        super.init(rootViewController: viewController)
    }
    
    override func transition(_ transition: TransitionRef) {
        guard let transition = transition as? SignUpRef else {
            return
        }
        
        switch transition {
        case .AdditionalDetails:
            showAdditionalDetails()
        default:
            break
        }
    }
}

extension SignUpCoordinator {

    func showAdditionalDetails() {
        let controller = AdditionalDetailsViewController.instantiateFromStoryBoard(storyboard: .Main, with: ViewModel())

        if #available(iOS 13, *) {
          controller.isModalInPresentation = true
        }
        
        self.show(controller)
    }
}
