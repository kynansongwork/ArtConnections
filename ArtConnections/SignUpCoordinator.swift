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
    
    required init () {
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
        default:
            break
        }
    }
}

extension SignUpCoordinator {

    func showAdditionalDetails(userObject: UserObject) {
        let controller = AdditionalDetailsViewController.instantiateFromStoryBoard(storyboard: .Main, with: AdditionalDetailsViewModel(coordinator: self, userObject: userObject), coordinator: self)

        if #available(iOS 13, *) {
          controller.isModalInPresentation = true
        }
        self.show(controller)
    }
}
