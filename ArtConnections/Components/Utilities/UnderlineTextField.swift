//
//  UnderlineTextField.swift
//  ArtConnections
//
//  Created by Kynan Song on 29/01/2020.
//  Copyright © 2020 scottishAsian. All rights reserved.
//

import UIKit
import Foundation

@IBDesignable class UnderlinedTextField: UITextField {

    let label = UILabel()
    let underline = UIView()
    var shouldValidate: Bool? = true
    var active: Bool? = true
    var underlineHeight: NSLayoutConstraint?
    var allowedCharSet: CharacterSet?
    var setCharacterLimit: Int?

    var valid: Bool? = true {
        didSet {
            setNeedsLayout()
        }
    }
    

    @IBInspectable var title: String? {
        didSet {
            self.setNeedsLayout()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        
        delegate = self

        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)

        label.translatesAutoresizingMaskIntoConstraints = false
        underline.translatesAutoresizingMaskIntoConstraints = false

        self.rightViewMode = .always
        
        self.addSubview(label)
        self.addSubview(underline)
        
        if let placeholder = self.placeholder {
             self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
       
        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        underline.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        underline.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        underline.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 3).isActive = true
        underline.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        underlineHeight = underline.heightAnchor.constraint(equalToConstant: 2)
        underlineHeight?.isActive = true

        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        self.setContentHuggingPriority(.required, for: .vertical)
        self.setContentHuggingPriority(.required, for: .horizontal)
        self.setContentCompressionResistancePriority(.required, for: .vertical)
        self.setContentCompressionResistancePriority(.required, for: .horizontal)
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.width, height: bounds.height - 10)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.width, height: bounds.height - 10)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        label.text = title
        label.textColor = .white
        underline.backgroundColor = .lightGray

        if active == false {
            underline.backgroundColor = .lightGray
        } else if shouldValidate == true {
            underline.backgroundColor = .gray
            if self.text?.isEmpty == false {
                underlineHeight?.constant = 2
                if valid == true {
                    underline.backgroundColor = .white
                } else {
                    underline.backgroundColor = .red
                }
            } else {
                underlineHeight?.constant = 1
            }
        }

    }
}

extension UnderlinedTextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let allowedCharSet = allowedCharSet {
            var cleanString = string.trimmingCharacters(in: allowedCharSet.inverted)
            cleanString = cleanString.replacingOccurrences(of: " ", with: "")
            if cleanString != string && string.contains(UIPasteboard.general.string ?? ""){
                textField.text = cleanString
                return false
            }
        }
        
        if setCharacterLimit != nil {
            let maxLength = setCharacterLimit
            if let enteredText: NSString = textField.text as NSString? {
                let newText: NSString = enteredText.replacingCharacters(in: range, with: string) as NSString
                return newText.length <= maxLength!
            }
            
        }
        
        return true
    }
}
