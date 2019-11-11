//
//  ProfileViewController.swift
//  ArtConnections
//
//  Created by Kynan Song on 25/09/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, StoryboardLoadedViewController {
    
    var viewModel: ProfileViewModel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var diciplineLabel: UILabel!
    @IBOutlet weak var portfolioCollectionView: UICollectionView!
    @IBOutlet weak var aboutTheUserView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if let userName = viewModel.user?.name {
            userNameLabel.text = userName
        }
        // Do any additional setup after loading the view.
        
        // save image in user-defaults or as a file on directory
    }

}
