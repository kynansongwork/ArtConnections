//
//  KeyboardViewController.swift
//  ArtConnections
//
//  Created by Kynan Song on 15/10/2019.
//  Copyright © 2019 scottishAsian. All rights reserved.
//

import Foundation
import UIKit

class KeyboardViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapRecogniser = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapRecogniser.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecogniser)
    }
    
    deinit {
        print("Deinit VC: \(NSStringFromClass(type(of: self)))")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc private func keyboardDidShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame?.origin.y ?? 0
            let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            if endFrameY >= UIScreen.main.bounds.size.height {
                keyboardDidChange(height: 0)
            } else {
                if let height = endFrame?.size.height {
                    keyboardDidChange(height: height)
                } else {
                    keyboardDidChange(height: 0)
                }
            }
            self.view.setNeedsLayout()
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
    
    public func keyboardDidChange(height: CGFloat) {
        // Override this method to update views when keyboard changes rect
    }
    
    @objc func dismissKeyboard() {
        // Override this method and call resignFirstResponder() on all UITextField instances
    }
    
}
