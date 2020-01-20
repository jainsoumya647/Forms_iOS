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
    
    init(rows: [FormDetailsTypes]) {
        self.rows = rows
    }
    
}

extension FormDetailsRender: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard  let cell = SingleInputCell.getDequeuedCell(for: tableView, indexPath: indexPath) as? SingleInputCell else { return UITableViewCell() }
        
        return cell
    }
    
}
