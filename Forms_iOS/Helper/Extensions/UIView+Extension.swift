//
//  UIView+Extension.swift
//  Forms_iOS
//
//  Created by Soumya on 22/01/20.
//  Copyright © 2020 Soumya. All rights reserved.
//

import UIKit

extension UIView {

    func setCornerRadius(radius: CGFloat = 5) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }

}
