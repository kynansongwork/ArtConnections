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
        setupKeyboardObservers()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeKeyboardObservers() {
         NotificationCenter.default.removeObserver(self)
       }
       
       @objc private func keyboardWillShow(_ notification: Notification) {
         let info = notification.userInfo
           if var keyboardRect = info?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
           keyboardRect = view.convert(keyboardRect, from: nil)
           self.view.frame.origin.y = -150
         }
         UIView.animate(withDuration: 0.3) {
           self.view.setNeedsLayout()
           self.view.layoutIfNeeded()
         }
       }

       @objc private func keyboardWillHide(_ notification: Notification) {
           
         self.view.frame.origin.y = 0
         UIView.animate(withDuration: 0.3) {
           self.view.setNeedsLayout()
           self.view.layoutIfNeeded()
         }
       }
    
    @objc func dismissKeyboard() {
        // Override this method and call resignFirstResponder() on all UITextField instances
    }
    
}
