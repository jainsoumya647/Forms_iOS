//
//  FormListRender.swift
//  Forms_iOS
//
//  Created by Soumya Jain on 20/01/20.
//  Copyright © 2020 Soumya. All rights reserved.
//

import UIKit
import RealmSwift

protocol FormListRenderDelegate: class {
    func moreOptionsClicked(index: Int)
}

class FormListRender: NSObject {
    
    var forms: Results<FormModel>?
    weak var delegate: FormListRenderDelegate?
    
    func updateForms(forms: Results<FormModel>) {
        self.forms = forms
    }
}

extension FormListRender: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.forms?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = FormsListCell.getDequeuedCell(for: tableView, indexPath: indexPath) as? FormsListCell,
            let form = self.forms?[indexPath.row] else {
            return UITableViewCell()
        }
        cell.configureCell(formModel: form)
        cell.moreOptionAction = { [weak self] in
            self?.delegate?.moreOptionsClicked(index: indexPath.row)
        }
        return cell
    }
}
