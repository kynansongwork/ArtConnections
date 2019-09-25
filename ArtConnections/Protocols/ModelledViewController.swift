//
//  ModelledViewController.swift
//  ArtConnections
//
//  Created by Kynan Song on 25/09/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import Foundation
import UIKit

protocol ModelledViewController: UIViewController, ViewModelDelegate {
    associatedtype AnyViewModel = ViewModel
    var viewModel: AnyViewModel! { get set }
    
    func setAsDelegate(for viewModel: ViewModel)
}

extension ModelledViewController {
    
    func setAsDelegate(for viewModel: ViewModel) {
        viewModel.delegate = self
    }
}
