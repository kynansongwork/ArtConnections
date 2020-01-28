//
//  RoundedButton.swift
//  ArtConnections
//
//  Created by Kynan Song on 28/01/2020.
//  Copyright © 2020 scottishAsian. All rights reserved.
//

import UIKit

@IBDesignable class RoundedButton: UIButton {
    
    private let contentView = UIView()
    let label = UILabel()
    let iconView = UIImageView()
    private var iconWidthAnchor: NSLayoutConstraint?
    private var labelLeadingAnchor: NSLayoutConstraint?
    
    @IBInspectable var title: String? {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var icon: UIImage? = nil {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bordered: Bool = false {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var buttonColour: UIColor = .systemPurple {
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
        self.isUserInteractionEnabled = true
        
        label.font = UIFont(name: "Baskerville", size: 15)
        label.textAlignment = .center
        
        iconView.contentMode = .scaleAspectFit
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(contentView)
        contentView.addSubview(label)
        contentView.addSubview(iconView)
        contentView.isUserInteractionEnabled = false
        
        contentView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        contentView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 12).isActive = true
        contentView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -12).isActive = true
        contentView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor).isActive = true
        contentView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor).isActive = true
        
        iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        iconView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        iconView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        iconWidthAnchor = iconView.widthAnchor.constraint(equalTo: iconView.heightAnchor)
        iconWidthAnchor?.isActive = true
        
        label.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        labelLeadingAnchor = label.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 0)
        labelLeadingAnchor?.isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        label.setContentHuggingPriority(.required, for: .horizontal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.height / 2
        layer.borderColor = buttonColour.cgColor
        layer.borderWidth = bordered ? 2 : 0
        
        let textColouring: UIColor
        
        if bordered {
            textColouring = buttonColour
        } else {
            textColouring = .white
        }
        
        label.textColor = textColouring
        iconView.image = icon
        label.text = title
        
        iconWidthAnchor?.isActive = icon == nil ? false : true
        labelLeadingAnchor?.constant = icon == nil ? 0 : 12
        
        if isEnabled {
            if isHighlighted {
                backgroundColor = bordered ? .clear : buttonColour
            } else {
                backgroundColor = bordered ? .clear : buttonColour
            }
        } else {
            backgroundColor = .lightGray
        }
    }
}
