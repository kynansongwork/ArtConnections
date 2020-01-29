//
//  ProfileViewController.swift
//  ArtConnections
//
//  Created by Kynan Song on 25/09/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import UIKit
import Firebase
import SwiftInstagram

class ProfileViewController: UIViewController, StoryboardLoadedViewController {
    
    var viewModel: ProfileViewModel!
    var loadingOverlay: LoadingWindowView?
    let instagramApi = Instagram.shared
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var diciplineLabel: UILabel!
    @IBOutlet weak var portfolioCollectionView: UICollectionView!
    @IBOutlet weak var aboutTheUserView: UITextView!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var signInButton: RoundedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        setUpImageView()
        loadingOverlay = LoadingWindowView(withTitle: "Loading", withSubtitle: "Please wait, processing")
        loadingOverlay?.show()
        viewModel.getUserdetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !instagramApi.isAuthenticated {
            print("Not authenticated")
            portfolioCollectionView.isHidden = true
            signInButton.isHidden = false
        } else {
            portfolioCollectionView.isHidden = false
            signInButton.isHidden = true
        }
    }
    
    func setUpImageView() {
        profileImageView.layer.borderWidth = 1.0
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
    }
    
    func updateView() {
        self.userNameLabel.text = viewModel.name
        self.diciplineLabel.text = viewModel.specialty
        self.aboutTheUserView.text = viewModel.profile
        self.websiteLabel.text = viewModel.website
        
        if let url = viewModel.imageUrl {
            //Need to improve image load time
            self.profileImageView.load(url: url)
        } else {
            self.profileImageView.image = UIImage(named: "placeHolderImage2")
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        print("Sign in tapped")
    }
    @IBAction func logOutTapped(_ sender: Any) {
        viewModel.logOut()
    }
}

extension ProfileViewController: ViewModelDelegate {
    
    func viewModelDidUpdate() {
        updateView()
        loadingOverlay?.hide()
    }
}
