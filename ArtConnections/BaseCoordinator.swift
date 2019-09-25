//
//  BaseCoordinator.swift
//  ArtConnections
//
//  Created by Kynan Song on 25/09/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import Foundation
import UIKit

enum StoryboardRef: String {
    case Profile
    case Login
}

protocol TransitionRef {}

class BaseCoordinator {
    weak var parentCoordinator: BaseCoordinator?
    var children: [BaseCoordinator] = []
    private(set) var rootViewController: UIViewController
    
    init<T: ModelledViewController>(rootViewController: T) {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.setNavigationBarHidden(true, animated: false)
        self.rootViewController = navController

        if let viewModel = rootViewController.viewModel as? ViewModel {
            viewModel.coordinator = self
        }
    }
    
    func transition(_ transition: TransitionRef) {
        fatalError("Tranistion method needs to be added to coordinator subclass")
    }
    
    final func present(_ child: BaseCoordinator, completion: (() -> Void)? = nil) {
        child.parentCoordinator = self
        self.children.append(child)
        rootViewController.present(child.rootViewController, animated: true, completion: completion)
    }
    
    final func dismiss(completion: (() -> Void)? = nil) {
        rootViewController.dismiss(animated: true) {
            self.parentCoordinator?.remove(self)
            completion?()
        }
    }
    
    final func remove(_ child: BaseCoordinator) {
        children = children.filter( { $0 !== child } )
    }
    
    final func show(_ viewController: UIViewController) {
        if let navController = rootViewController as? UINavigationController {
            navController.show(viewController, sender: self)
        }
    }
}