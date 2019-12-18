//
//  CustomActivityIndicator.swift
//  ArtConnections
//
//  Created by Kynan Song on 18/12/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import Foundation
import UIKit

import UIKit

class CustomActivityIndicator: UIImageView {
    
    var timer: Timer?
    
    private var fps: Double {
        if #available(iOS 10.3, *) { return Double(UIScreen.main.maximumFramesPerSecond) } else { return 30 }
    }
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        contentMode = .scaleAspectFit
        timer = Timer.scheduledTimer(timeInterval: 1/fps, target: self, selector: #selector(animate), userInfo: nil, repeats: true)
    }
    
    @objc private func animate() {
        self.transform = self.transform.rotated(by: CGFloat.pi / CGFloat(fps / 2))
    }
}
