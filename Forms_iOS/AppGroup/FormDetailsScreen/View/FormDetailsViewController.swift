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
        self.observeEvents()
        self.render = FormDetailsRender(viewModel: self.viewModel)
        self.collectionRender = ImageCollectionViewRender(imagesArray: self.viewModel.getImages(), size: CGSize(width: 90, height: 90))
        self.collectionRender?.openImagePicker = { [weak self] in
            print("opening image picker...")
            guard let current = self else {
                return
            }
            current.collectionRender?.updateImagesArray(imagesArray: current.viewModel.getImages())
            current.openGallery()
        }
    }
    
    private func observeEvents() {
        self.viewModel.updateAndReloadCollection = { [weak self] (imagesArray) in
            self?.collectionRender?.updateImagesArray(imagesArray: imagesArray)
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
        self.imagesCollectionView.backgroundColor = .tableBackgroundColor
    }

    class func getController() -> FormDetailsViewController? {
        return self.initalizeMyViewController(identifier: .formDetails, storyboard: .main) as? FormDetailsViewController
    }
    
}

extension FormDetailsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.viewModel.appendImage(image: image)
        }
        picker.dismiss(animated: true, completion: nil)
    }

}
