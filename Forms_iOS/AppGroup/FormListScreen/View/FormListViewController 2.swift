//
//  FormListViewController.swift
//  Forms_iOS
//
//  Created by Soumya on 20/01/20.
//  Copyright © 2020 Soumya. All rights reserved.
//

import UIKit

class FormListViewController: UIViewController {

    @IBOutlet weak var formsListTable: UITableView!
    
    var render: FormListRender!
    var viewModel: FormsListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViews()
    }
    
    private func configureViews() {
        self.initalizeData()
        self.configureTableView()
    }
    
    private func initalizeData() {
        self.viewModel = FormsListViewModel()
        self.render = FormListRender(forms: [FormModel]())
        self.render.delegate = self
        self.observeEvents()
    }
    
    private func observeEvents() {
        self.viewModel.reloadTable = { [weak self] (forms: [FormModel]) in
            self?.render.updateForms(forms: forms)
            self?.formsListTable.reloadData()
        }
    }
    
    private func configureTableView() {
        FormsListCell.registerWithTable(self.formsListTable)
        self.register(table: self.formsListTable)
        self.formsListTable.dataSource = self.render
        self.formsListTable.backgroundColor = .tableBackgroundColor
    }
    
    @IBAction func addFormAction(_ sender: Any) {
        if let vc = FormDetailsViewController.getController() {
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension FormListViewController: FormListRenderDelegate {
    func moreOptionsClicked(index: Int) {
        self.presentActionSheet { [weak self] in
            self?.viewModel.removeModel(on: index)
        }
    }
}

extension FormListViewController: FormDetailsDelegate {
    func formSaved(form: FormModel) {
        print(form)
        self.viewModel.appendForms(form)
    }
}
