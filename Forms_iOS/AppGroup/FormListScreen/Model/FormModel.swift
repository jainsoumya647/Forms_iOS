//
//  FormModel.swift
//  Forms_iOS
//
//  Created by Soumya Jain on 20/01/20.
//  Copyright © 2020 Soumya. All rights reserved.
//

import Foundation
import RealmSwift

class FormModel: Object {
    @objc dynamic var formTitle: String?
    @objc dynamic var formDescription: String?
    @objc dynamic var budget: String?
    @objc dynamic let currency = "US"
    @objc dynamic var rate: String?
    @objc dynamic var paymentMethod: String?
    @objc dynamic var startDate: Date?
    @objc dynamic var jobTerm: String?
    @objc dynamic var numberOfViews:Int
    
    required init() {
        self.numberOfViews = Int.random(in: 0...999)
    }
    
    func getTitle() -> String {
        return self.formTitle ?? ""
    }

    func getDescription() -> String {
        return self.formDescription ?? ""
    }

    func getBudget() -> String {
        return self.budget ?? ""
    }

    func getCurrency() -> String {
        return self.currency 
    }

    func getRate() -> String {
        return self.rate ?? ""
    }

    func getPaymentMethod() -> String {
        return self.paymentMethod ?? ""
    }

    func getStartDate(format: String = "EEEE dd MMM") -> String {
        return self.startDate?.convertUTCToLocalInString(with: format) ?? ""
    }

    func getJobTerm() -> String {
        return self.jobTerm ?? ""
    }
    
    func getNumberOfViews() -> String {
        return "\(numberOfViews) \(Text.views)"
    }
}
