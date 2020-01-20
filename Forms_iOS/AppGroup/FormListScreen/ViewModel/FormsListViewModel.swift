//
//  FormsListViewModel.swift
//  Forms_iOS
//
//  Created by Soumya Jain on 20/01/20.
//  Copyright © 2020 Soumya. All rights reserved.
//

import UIKit

class FormsListViewModel {
    private var forms = [FormModel]()
    var reloadTable: ((_ forms: [FormModel]) -> Void)?
    
    func removeModel(on index: Int) {
        guard self.forms.count > index else {
            return
        }
        self.forms.remove(at: index)
        self.reloadTable?(self.forms)
    }
}
