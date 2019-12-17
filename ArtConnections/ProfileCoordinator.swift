//
//  ProfileCoordinator.swift
//  ArtConnections
//
//  Created by Kynan Song on 25/09/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import Foundation
import UIKit

enum ProfileRef: TransitionRef {

}

class ProfileCoordinator: BaseCoordinator {
    
    required init () {
        let viewController = ProfileViewController.instantiateFromStoryBoard(storyboard: .Main, with: ProfileViewModel())
        super.init(rootViewController: viewController)
    }
    
    override func transition(_ transition: TransitionRef) {
        guard let transition = transition as? ProfileRef else {
            return
        }
    }
    
}

extension ProfileCoordinator {
    
}
