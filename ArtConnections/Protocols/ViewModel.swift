//
//  ViewModel.swift
//  ArtConnections
//
//  Created by Kynan Song on 25/09/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import Foundation

class ViewModel {
    weak var coordinator: BaseCoordinator?
    weak var delegate: ViewModelDelegate?
}

protocol ViewModelDelegate: class {
    func viewModelDidUpdate()
    func viewModelDidError(error: Error)
}

extension ViewModelDelegate {
    //Makes the protocol methods optional
    func viewModelDidUpdate() {}
    func viewModelDidError(error: Error) {
        print("View model error: \(error)")
    }
}
