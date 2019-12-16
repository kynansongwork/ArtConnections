//
//  ViewModel.swift
//  ArtConnections
//
//  Created by Kynan Song on 25/09/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import Foundation

class ViewModel: NSObject {
    weak var coordinator: BaseCoordinator?
    weak var delegate: ViewModelDelegate?
    
    override init() {
        super.init()
    }
    
    init(coordinator: BaseCoordinator) {
        self.coordinator = coordinator
        super.init()
    }
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
