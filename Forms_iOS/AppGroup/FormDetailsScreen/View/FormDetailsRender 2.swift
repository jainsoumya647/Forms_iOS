//
//  FormDetailsRender.swift
//  Forms_iOS
//
//  Created by Soumya Jain on 21/01/20.
//  Copyright © 2020 Soumya. All rights reserved.
//

import UIKit

class FormDetailsRender: NSObject {
    var rows: [FormDetailsTypes]
    var viewModel: FormDetailsViewModel
    var showError = false
    
    init(viewModel: FormDetailsViewModel) {
        self.rows = viewModel.getTypes()
        self.viewModel = viewModel
    }
    
}

extension FormDetailsRender: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = TextInputCell.getDequeuedCell(for: tableView, indexPath: indexPath) as? TextInputCell else { return UITableViewCell() }
        cell.configureCell(type: self.rows[indexPath.row], viewModel: self.viewModel, showError: self.showError)
        return cell
    }
    
}
