//
//  LoadingWindowView.swift
//  ArtConnections
//
//  Created by Kynan Song on 18/12/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import Foundation
import UIKit

class LoadingWindowView {
    
    let window = UIWindow()
    
    init(withTitle title: String? = nil, withSubtitle subtitle: String? = nil) {
        window.windowLevel = UIWindow.Level.alert
        window.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        
        let activityIndicator = CustomActivityIndicator()
        activityIndicator.image = UIImage(named: "loadingSpinner")
        
        window.addSubview(activityIndicator)
        activityIndicator.center = CGPoint(x: window.bounds.midX, y: window.bounds.midY - 40)
        
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.text = title
        label.numberOfLines = 2
        label.font = UIFont(name: "Roboto-Regular", size: 20)
        
        window.addSubview(label)
        label.frame = CGRect(x: 0, y: activityIndicator.frame.maxY - 50, width: window.frame.width, height: 100)
        
        let subtitleLabel = UILabel()
        subtitleLabel.textAlignment = .center
        subtitleLabel.text = subtitle
        subtitleLabel.numberOfLines = 2
        subtitleLabel.font = UIFont(name: "Roboto-Regular", size: 13)
        subtitleLabel.textColor = .lightGray
        
        window.addSubview(subtitleLabel)
        subtitleLabel.frame = CGRect(x: 0, y: activityIndicator.frame.maxY - 20, width: window.frame.width, height: 100)

    }
    
    func show() {
        window.makeKeyAndVisible()
    }
    
    func hide() {
        window.isHidden = true
    }
    
}
