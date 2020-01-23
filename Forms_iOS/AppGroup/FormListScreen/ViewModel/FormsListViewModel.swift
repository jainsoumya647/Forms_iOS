//
//  FormsListViewModel.swift
//  Forms_iOS
//
//  Created by Soumya Jain on 20/01/20.
//  Copyright © 2020 Soumya. All rights reserved.
//

import UIKit
import RealmSwift

class FormsListViewModel {
    private var forms: Results<FormModel>?
    var reloadTable: ((_ forms: Results<FormModel>) -> Void)?

    init() {
        DataStore.shared.retriveDataFromStore { (forms) in
            self.forms = forms
        }
    }

    func removeModel(on index: Int) {
        guard let forms = self.forms, forms.count > index else {
            return
        }
        DataStore.shared.deleteDataFromStore(model: forms[index]) {
            DataStore.shared.retriveDataFromStore { (forms) in
                self.forms = forms
                self.reloadTable?(forms)
            }
        }
    }
    
    func appendForms(_ form: FormModel) {
        DataStore.shared.retriveDataFromStore { (forms) in
            self.forms = forms
            self.reloadTable?(forms)
        }
    }

    func getForms() -> Results<FormModel>? {
        return self.forms
    }

    ///Only for unit tests
    func formsCountEqualsTo(_ count: Int) -> Bool {
        return (self.forms?.count ?? 0) == count
    }
}
