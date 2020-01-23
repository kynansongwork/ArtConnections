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
    case SignedIn
}

class AppCoordinator: BaseCoordinator {
    
    let tabBarController = UITabBarController()
    
    var profileCoordinator: ProfileCoordinator?
    let profileItem = UITabBarItem(title: "Profile", image: UIImage(named: "icTabProfileActive"), tag: 0)
    
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
        case .SignedIn:
            presetProfile()
        default:
            break
        }
    }
    
    func enterTheApp() {
        profileCoordinator = ProfileCoordinator()
        profileCoordinator?.parentCoordinator = self
        profileCoordinator!.rootViewController.tabBarItem = profileItem
        
        tabBarController.viewControllers = [profileCoordinator!.rootViewController]
    }
}

extension AppCoordinator {
    
    func presentLoginFlow() {
        let loginCoordinator = LoginCoordinator()
        try? present(loginCoordinator)
    }
    
    func presetProfile() {
        let profileCoordinator = ProfileCoordinator()
        try? present(profileCoordinator)
    }
}
