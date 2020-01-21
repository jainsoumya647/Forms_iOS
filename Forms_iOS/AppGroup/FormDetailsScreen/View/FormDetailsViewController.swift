//
//  FormDetailsViewController.swift
//  Forms_iOS
//
//  Created by Soumya Jain on 21/01/20.
//  Copyright © 2020 Soumya. All rights reserved.
//

import UIKit

class FormDetailsViewController: UIViewController {

    @IBOutlet weak var formDetailsTable: UITableView!
    var render: FormDetailsRender!
    var viewModel: FormDetailsViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViews()
    }
    
    private func configureViews() {
        self.initalizeData()
        self.setupTableView()
    }
    
    private func initalizeData() {
        self.viewModel = FormDetailsViewModel()
        self.render = FormDetailsRender(viewModel: self.viewModel)
    }
    
    private func setupTableView() {
        self.register(table: self.formDetailsTable)
        self.formDetailsTable.dataSource = self.render
        TextInputCell.registerWithTable(self.formDetailsTable)
    }

    class func getController() -> FormDetailsViewController? {
        return self.initalizeMyViewController(identifier: .formDetails, storyboard: .main) as? FormDetailsViewController
    }
    
}
