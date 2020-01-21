//
//  FormDetailsViewController.swift
//  Forms_iOS
//
//  Created by Soumya Jain on 21/01/20.
//  Copyright © 2020 Soumya. All rights reserved.
//

import UIKit

protocol FormDetailsDelegate: class {
    func formSaved(form: FormModel)
}

class FormDetailsViewController: UIViewController {

    @IBOutlet weak var formDetailsTable: UITableView!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    var render: FormDetailsRender!
    var viewModel: FormDetailsViewModel!
    weak var delegate: FormDetailsDelegate?
    var collectionRender: ImageCollectionViewRender?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViews()
    }
    
    deinit {
        print("=======   FormDetailsViewController deinit   ========")
    }
    
    private func configureViews() {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Send", style: .plain, target: self, action: #selector(sendAction))
        self.initalizeData()
        self.setupTableView()
        self.setupCollectionView()
    }
    
    @objc private func sendAction() {
        
        guard let model = self.viewModel.validateDataAndGetForms() else {
            self.render.showError = true
            self.formDetailsTable.reloadData()
            return
        }
        self.delegate?.formSaved(form: model)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func initalizeData() {
        self.viewModel = FormDetailsViewModel()
        self.render = FormDetailsRender(viewModel: self.viewModel)
        self.collectionRender = ImageCollectionViewRender(imagesArray: self.viewModel.getImages())
    }
    
    private func observeEvents() {
        self.viewModel.reloadCollection = { [weak self] in
            self?.imagesCollectionView.reloadData()
        }
    }
    
    private func setupTableView() {
        self.register(table: self.formDetailsTable)
        self.formDetailsTable.dataSource = self.render
        TextInputCell.registerWithTable(self.formDetailsTable)
    }
    
    private func setupCollectionView() {
        ImageCollectionCell.registerWithCollection(self.imagesCollectionView)
        self.imagesCollectionView.delegate = self.collectionRender
        self.imagesCollectionView.dataSource = self.collectionRender
    }

    class func getController() -> FormDetailsViewController? {
        return self.initalizeMyViewController(identifier: .formDetails, storyboard: .main) as? FormDetailsViewController
    }
    
}
