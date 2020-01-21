//
//  Constants.swift
//  Forms_iOS
//
//  Created by Soumya on 20/01/20.
//  Copyright © 2020 Soumya. All rights reserved.
//

import UIKit

enum Storyboard: String {
    case main = "Main"
}

enum Controller: String {
    case formDetails = "FormDetailsViewController"
}

struct Text {
    static let ok = "Ok"
    static let formTitle = "Form Title"
    static let formDescription = "Form Description"
    static let budget = "Budget"
    static let rate = "Rate"
    static let paymentMethod = "Payment Method"
    static let startDate = "Start Date"
    static let jobTerm = "Job Term"
    static let attachments = "Attachments"
    static let required = "Required"
    static let charactersLeft = "characters left"
    static let noPreference = "No Preference"
    static let fixedBudget = "Fixed Budget"
    static let hourlyRate = "Hourly Rate"
    static let ePayment = "E-Payment"
    static let cash = "Cash"
    static let recurringJob = "Recurring Job"
    static let sameDayJob = "Same Day Job"
    static let multiDaysJob = "Multi Days Job"
    static let views = "views"
}

struct FontSize {
    static var smaller: CGFloat = FontSize.getCustomSizeOf(font: 10)
    static var small: CGFloat = FontSize.getCustomSizeOf(font: 12)
    static var regular: CGFloat = FontSize.getCustomSizeOf(font: 14)
    static var semiMedium: CGFloat = FontSize.getCustomSizeOf(font: 16)
    static var medium: CGFloat = FontSize.getCustomSizeOf(font: 18)
    static var large: CGFloat = FontSize.getCustomSizeOf(font: 20)
    static var larger: CGFloat = FontSize.getCustomSizeOf(font: 24)
    static var largest: CGFloat = FontSize.getCustomSizeOf(font: 30)
    static private func getCustomSizeOf(font: CGFloat) -> CGFloat {
        return font.configureAccordingToScreen()
    }
}
