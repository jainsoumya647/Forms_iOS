//
//  UIButton+Extension.swift
//  Forms_iOS
//
//  Created by Soumya Jain on 20/01/20.
//  Copyright © 2020 Soumya. All rights reserved.
//

import UIKit

extension UIButton {
    func configureSolidBackgroundColor() {
        self.backgroundColor = .themeBlueColor
        self.titleLabel?.configureWhiteTextLabel(fontSize: FontSize.semiMedium)
        self.setTitleColor(.white, for: .normal)
    }
    
    func configureBorderColor() {
        self.layer.borderColor = UIColor.themeBlueColor.cgColor
        self.layer.borderWidth = 1
        self.titleLabel?.configureLabel(fontSize: FontSize.semiMedium)
        self.setTitleColor(.themeBlueColor, for: .normal)
    }
}
