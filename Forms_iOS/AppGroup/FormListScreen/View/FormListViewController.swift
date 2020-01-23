//
//  FormListViewController.swift
//  Forms_iOS
//
//  Created by Soumya on 20/01/20.
//  Copyright © 2020 Soumya. All rights reserved.
//

import UIKit
import RealmSwift

class FormListViewController: UIViewController {

    @IBOutlet weak var formsListTable: UITableView!
    @IBOutlet weak var addFormButton: UIBarButtonItem!

    var render: FormListRender!
    var viewModel: FormsListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViews()
    }
    
    private func configureViews() {
        self.initalizeData()
        self.configureTableView()
        self.addAccessibilityIdentifiers()
    }
    
    private func initalizeData() {
        self.viewModel = FormsListViewModel()
        self.render = FormListRender()
        if let forms = self.viewModel.getForms() {
            self.render.updateForms(forms: forms)
        }
        self.render.delegate = self
        self.observeEvents()
    }
    
    private func observeEvents() {
        self.viewModel.reloadTable = { [weak self] (forms: Results<FormModel>) in
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

    private func addAccessibilityIdentifiers() {
        self.addFormButton.accessibilityIdentifier = "Add"
        self.formsListTable.accessibilityIdentifier = "FormsList"
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
        DataStore.shared.saveDataToStore(model: form) {
            self.viewModel.appendForms(form)
        }
    }
}
