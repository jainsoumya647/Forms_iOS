//
//  FormListRender.swift
//  Forms_iOS
//
//  Created by Soumya Jain on 20/01/20.
//  Copyright © 2020 Soumya. All rights reserved.
//

import UIKit

protocol FormListRenderDelegate: class {
    func moreOptionsClicked(index: Int)
}

class FormListRender: NSObject {
    
    var forms: [FormModel]
    weak var delegate: FormListRenderDelegate?
    init(forms: [FormModel]) {
        self.forms = forms
    }
    
    func updateForms(forms: [FormModel]) {
        self.forms = forms
    }
}

extension FormListRender: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 //self.forms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = FormsListCell.getDequeuedCell(for: tableView, indexPath: indexPath) as? FormsListCell else {
            return UITableViewCell()
        }
        
        cell.moreOptionAction = { [weak self] in
            self?.delegate?.moreOptionsClicked(index: indexPath.row)
        }
        return cell
    }
    
}
