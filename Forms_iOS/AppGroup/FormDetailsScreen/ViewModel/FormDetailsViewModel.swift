//
//  FormDetailsViewModel.swift
//  Forms_iOS
//
//  Created by Soumya Jain on 21/01/20.
//  Copyright © 2020 Soumya. All rights reserved.
//

import UIKit

enum FormDetailsTypes {
    case formTitle
    case formDescription
    case budget
    case currency
    case rate
    case paymentMethod
    case startDate
    case jobTerm
}

class FormDetailsViewModel {
    
    private var types: [FormDetailsTypes]
    private var formModel = FormModel()
    init() {
        self.types = [.formTitle, .formDescription, .budget, .rate, .startDate]
    }
    
    func getTypes() -> [FormDetailsTypes] {
        return self.types
    }

    func getPlaceholderText(for type: FormDetailsTypes) -> String {
        switch type {
        case .formTitle:
            return Text.formTitle
        case .formDescription:
            return Text.formDescription
        case .budget:
            return Text.budget
        case .currency:
            return ""
        case .rate:
            return Text.rate
        case .paymentMethod:
            return Text.paymentMethod
        case .startDate:
            return Text.startDate
        case .jobTerm:
            return Text.jobTerm
        }
    }

    func getRequiredLabelTextAndColor(for type: FormDetailsTypes, showError: Bool) -> (String, UIColor) {
        let text = self.getText(for: type)
        let errorColor: UIColor = showError ? .red : .lightGray
        switch type {
        case .formTitle:
            if text.isEmpty {
                return (Text.required, errorColor)
            } else {
                let count = self.getCharacterCount(for: type)
                return  ("\(count - text.count) \(Text.charactersLeft)", .lightGray)
            }
        case .formDescription:
            let count = self.getCharacterCount(for: type)
            return  ("\(count - text.count) \(Text.charactersLeft)", .lightGray)
        default:
            if text.isEmpty {
                return (Text.required, errorColor)
            } else {
                return (Text.required, .lightGray)
            }
        }
    }

    func getText(for type: FormDetailsTypes) -> String {
       switch type {
        case .formTitle:
            return self.formModel.getTitle()
        case .formDescription:
            return self.formModel.getDescription()
        case .budget:
            return self.formModel.getBudget()
        case .currency:
            return self.formModel.getCurrency()
        case .rate:
            return self.formModel.getRate()
        case .paymentMethod:
            return self.formModel.getPaymentMethod()
        case .startDate:
            return self.formModel.getStartDate()
        case .jobTerm:
            return self.formModel.getJobTerm()
        }
    }

    func getRelatedSecondaryType(for type: FormDetailsTypes) -> FormDetailsTypes? {
        switch type {
        case .budget:
            return .currency
        case .rate:
            return .paymentMethod
        case .startDate:
            return .jobTerm
        default:
            return .none
        }
    }

    func updateText(for type: FormDetailsTypes, updatedText: String) {
        switch type {
        case .formTitle:
            self.formModel.formTitle = updatedText
        case .formDescription:
            self.formModel.formDescription = updatedText
        case .budget:
            self.formModel.budget = updatedText
        case .rate:
            self.formModel.rate = updatedText
        case .paymentMethod:
            self.formModel.paymentMethod = updatedText
        case .startDate:
            self.formModel.startDate = updatedText
        case .jobTerm:
            self.formModel.jobTerm = updatedText
        default:
            break
        }
    }

    func getCharacterCount(for type: FormDetailsTypes) -> Int {
        switch type {
        case .formTitle:
            return 50
        case .formDescription:
            return 330
        default:
            return NSIntegerMax
        }
    }

    func getPickerArray(for type: FormDetailsTypes) -> [String] {
        switch type {
        case .rate:
            return [Text.noPreference, Text.fixedBudget, Text.hourlyRate]
        case .paymentMethod:
            return [Text.noPreference, Text.ePayment, Text.cash]
        case .jobTerm:
            return [Text.noPreference, Text.recurringJob, Text.sameDayJob, Text.multiDaysJob]
        default:
            return [String]()
        }

    }
}
