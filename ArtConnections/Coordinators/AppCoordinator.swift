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
}

class AppCoordinator: BaseCoordinator {
    
    init() {
        let viewController = WelcomeViewController.instantiateFromStoryBoard(storyboard: .Main, with: ViewModel())
        super.init(rootViewController: viewController)
    }
    
    override func transition(_ transition: TransitionRef) {
        guard let transition = transition as? BaseTransitionRef else {
            return
        }
        
        switch transition {
        case .Login:
            presentLoginFlow()
        default:
            break
        }
    }
}

extension AppCoordinator {
    
    func presentLoginFlow() {
        let loginCoordinator = LoginCoordinator()
        try? present(loginCoordinator)
    }
}
