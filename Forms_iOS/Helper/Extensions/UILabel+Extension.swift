//
//  UILabel+Extension.swift
//  Forms_iOS
//
//  Created by Soumya Jain on 20/01/20.
//  Copyright © 2020 Soumya. All rights reserved.
//

import UIKit

extension UILabel {

    func configureLabel(fontSize size: CGFloat) {
        self.font = UIFont.systemFont(ofSize: size)
        self.textColor = UIColor.themeBlueColor
    }
    
    func configurePlaceholderLabel(fontSize size: CGFloat) {
        self.font = UIFont.systemFont(ofSize: size)
        self.textColor = UIColor.placeholderColor
    }
    
    func configureWhiteTextLabel(fontSize size: CGFloat) {
        self.font = UIFont.systemFont(ofSize: size)
        self.textColor = UIColor.themeBlueColor
    }
}
