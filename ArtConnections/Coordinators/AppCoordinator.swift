//
//  AppCoordinator.swift
//  ArtConnections
//
//  Created by Kynan Song on 25/09/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import Foundation
import UIKit

enum BaseTransitionRef: TransitionRef {
    case Login
    case Profile
}

class AppCoordinator: BaseCoordinator {
    
    init() {
        let viewController = ProfileViewController.instantiateFromStoryBoard(storyboard: .Main, with: ProfileViewModel())
        super.init(rootViewController: viewController)
    }
    
    override func transition(_ transition: TransitionRef) {
        guard let transition = transition as? BaseTransitionRef else {
            return
        }
        
        switch transition {
        case .Login:
            break
        case .Profile:
            break
        default:
            break
        }
    }
}

extension AppCoordinator {
    
    //Insert case methods here
}
