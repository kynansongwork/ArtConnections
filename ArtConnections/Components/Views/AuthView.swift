//
//  AuthView.swift
//  ArtConnections
//
//  Created by Kynan Song on 29/01/2020.
//  Copyright © 2020 scottishAsian. All rights reserved.
//

import Foundation
import UIKit

class AuthView: KeyboardViewController, StoryboardLoadedViewController {
    var viewModel: ViewModel!
    
    
    @IBOutlet weak var authView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
    }
    
    @IBAction func dismissSignInView(_ sender: Any) {
    }
}
