//
//  Date+Extension.swift
//  Forms_iOS
//
//  Created by Soumya on 21/01/20.
//  Copyright © 2020 Soumya. All rights reserved.
//

import UIKit

extension Date {

    func convertUTCToLocalInString(with format: String = "EEEE dd MMM") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}
