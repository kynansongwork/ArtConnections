//
//  ProfileViewController.swift
//  ArtConnections
//
//  Created by Kynan Song on 25/09/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController, StoryboardLoadedViewController {
    
    var viewModel: ProfileViewModel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var diciplineLabel: UILabel!
    @IBOutlet weak var portfolioCollectionView: UICollectionView!
    @IBOutlet weak var aboutTheUserView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        viewModel.getUserdetails()
    }
    
    func updateView() {
        self.userNameLabel.text = viewModel.name
        self.diciplineLabel.text = viewModel.specialty
        self.aboutTheUserView.text = viewModel.profile
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
}

extension ProfileViewController: ViewModelDelegate {
    
    func viewModelDidUpdate() {
        //Put activity indicator stop here
        updateView()
    }
}
