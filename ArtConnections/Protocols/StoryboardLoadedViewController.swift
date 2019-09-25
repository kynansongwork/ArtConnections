//
//  StoryboardLoadedViewController.swift
//  ArtConnections
//
//  Created by Kynan Song on 25/09/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import UIKit

protocol StoryboardLoadedViewController: ModelledViewController {
    static func instantiateFromStoryBoard(storyboard: StoryboardRef, with viewModel: ViewModel, coordinator: BaseCoordinator?) -> Self
}

extension StoryboardLoadedViewController {
    
    static func instantiateFromStoryBoard(storyboard: StoryboardRef, with viewModel: ViewModel, coordinator: BaseCoordinator? = nil) -> Self {
        let className = NSStringFromClass(self).components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: className) as! Self
        vc.viewModel = (viewModel as! Self.AnyViewModel)
        vc.setAsDelegate(for: viewModel)
        viewModel.coordinator = coordinator
        return vc
    }
}

//https://github.com/StewThom/MVVM-C-Demo-App/blob/master/MVVM-C%20Demo%20App/Protocols/StoryboardLoadedViewController.swift
