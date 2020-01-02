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
    case Main
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
        self.rootViewController = navController

        if let viewModel = rootViewController.viewModel as? ViewModel {
            viewModel.coordinator = self
        }
    }
    
    func transition(_ transition: TransitionRef) {
        fatalError("Tranistion method needs to be added to coordinator subclass")
    }
    
    func transition(_ transition: TransitionRef, object: Any? = nil) {
        fatalError("Tranistion method needs to be added to coordinator subclass")
    }
    
    func presentAlert(title: String, message: String) {
        //Temporary alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        
        let controller = UIViewController()
        controller.present(alert, animated: true, completion: nil)
    }
    
    final func present(_ child: BaseCoordinator, completion: (() -> Void)? = nil) {
        child.parentCoordinator = self
        self.children.append(child)
        if let navController = child.rootViewController as? UINavigationController {
            
            if #available(iOS 13, *) {
              navController.isModalInPresentation = true
            }
            
            rootViewController.present(navController, animated: true, completion: completion)
        }
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
