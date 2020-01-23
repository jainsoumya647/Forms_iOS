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
    var dataStore = DataStore()

    init() {
        self.addDataStoreObservers()
        self.dataStore.retriveDataFromStore()
    }

    func addDataStoreObservers() {
        self.dataStore.updateUI = { [weak self] (forms) in
            self?.forms = forms
            self?.reloadTable?(forms)
        }
    }

    func removeModel(on index: Int) {
        guard let forms = self.forms, forms.count > index else {
            return
        }
        self.dataStore.deleteDataFromStore(model: forms[index])
    }
    
    func appendForms(_ form: FormModel) {
        self.dataStore.saveDataToStore(model: form)
    }

    func getForms() -> Results<FormModel>? {
        return self.forms
    }

    ///Only for unit tests
    func formsCountEqualsTo(_ count: Int) -> Bool {
        return (self.forms?.count ?? 0) == count
    }
}
