//
//  FormDetailsViewModel.swift
//  Forms_iOS
//
//  Created by Soumya Jain on 21/01/20.
//  Copyright © 2020 Soumya. All rights reserved.
//

import Foundation

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
    
    init() {
        self.types = [.formTitle, .formDescription, .budget, .rate, .startDate]
    }
    
    func getTypes() -> [FormDetailsTypes] {
        return self.types
    }
    
}
