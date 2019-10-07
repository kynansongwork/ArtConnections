//
//  LoginCoordinator.swift
//  ArtConnections
//
//  Created by Kynan Song on 25/09/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import Foundation

enum LoginRef: TransitionRef {
    case Login
    case Profile
}

class LoginCoordinator: BaseCoordinator {
    
}

extension LoginCoordinator {
    
    func showProfilePage() {
        let controller = ProfileViewController.instantiateFromStoryBoard(storyboard: .Main, with: ProfileViewModel())
        self.show(controller)
    }
}
