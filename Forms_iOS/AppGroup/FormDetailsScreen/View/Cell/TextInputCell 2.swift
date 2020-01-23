//
//  TextInputCell.swift
//  Forms_iOS
//
//  Created by Soumya Jain on 21/01/20.
//  Copyright © 2020 Soumya. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class TextInputCell: ReusableTableViewCell {

    @IBOutlet weak var inputTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var secondaryInputTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var requiredLabel: UILabel!
    @IBOutlet weak var secondaryStack: UIStackView!

    var type: FormDetailsTypes!
    var viewModel: FormDetailsViewModel!
    var pickerViewRender: PickerViewRender?
    var pickerViewSecondaryRender: PickerViewRender?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setuCell()
    }

    private func setuCell() {
        self.inputTextField.configureTextField()
        self.secondaryInputTextField.configureTextField()
        self.requiredLabel.configurePlaceholderLabel(fontSize: FontSize.small)
        self.inputTextField.delegate = self
    }

    func configureCell(type: FormDetailsTypes, viewModel: FormDetailsViewModel, showError: Bool) {
        self.type = type
        self.viewModel = viewModel
        self.inputTextField.placeholder = self.viewModel.getPlaceholderText(for: type)
        self.setupTextFieldsAccording(to: type)
        self.updateRequiredLabel(for: type, showError: showError)
        self.inputTextField.text = viewModel.getText(for: type)
        self.fillupSecondoryField(type: type)
    }

    private func updateRequiredLabel(for type: FormDetailsTypes, showError: Bool) {
        switch type {
        case .rate:
            self.requiredLabel.text = ""
        default:
            let (requiredText, requiredColor) = self.viewModel.getRequiredLabelTextAndColor(for: type, showError: showError)
            self.requiredLabel.text = requiredText
            self.requiredLabel.textColor = requiredColor
        }
    }

    private func fillupSecondoryField(type: FormDetailsTypes) {
        guard let relatedType = self.viewModel.getRelatedSecondaryType(for: type) else { return }
        self.secondaryInputTextField.text = self.viewModel.getText(for: relatedType)
        self.secondaryInputTextField.placeholder = self.viewModel.getPlaceholderText(for: relatedType)
        self.setupTextFieldsAccording(to: relatedType)
    }

    private func setupTextFieldsAccording(to type: FormDetailsTypes) {
        switch type {
        case .formTitle, .formDescription:
            self.inputTextField.keyboardType = .default
            self.showSecondaryStack(false)
        case .budget, .currency:
            self.inputTextField.keyboardType = .numberPad
            self.showSecondaryStack(true)
            self.setSecondaryFlag(true)
        case .rate:
            self.showSecondaryStack(true)
            self.setSecondaryFlag(false)
            self.setupPickerView(type: type, isPrimary: true)
        case .paymentMethod, .jobTerm:
            self.showSecondaryStack(true)
            self.setSecondaryFlag(false)
            self.setupPickerView(type: type, isPrimary: false)
        case .startDate:
            self.showSecondaryStack(true)
            self.setSecondaryFlag(false)
            let picker = UIDatePicker()
            picker.datePickerMode = .date
            picker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
            self.inputTextField.inputView = picker
        }
    }

    private func setupPickerView(type: FormDetailsTypes, isPrimary: Bool) {
        if isPrimary {
            let picker = UIPickerView()
            self.pickerViewRender = PickerViewRender(array: self.viewModel.getPickerArray(for: type), type: type)
            self.pickerViewRender?.selectedValue = { (selectedValue, type) in
                self.inputTextField.text = selectedValue
                self.viewModel.updateText(for: type, updatedText: selectedValue)
            }
            picker.dataSource = self.pickerViewRender
            picker.delegate = self.pickerViewRender
            self.inputTextField.inputView = picker
        } else {
            let picker = UIPickerView()
            self.pickerViewSecondaryRender = PickerViewRender(array: self.viewModel.getPickerArray(for: type), type: type)
            self.pickerViewSecondaryRender?.selectedValue = { (selectedValue, type) in
                self.secondaryInputTextField.text = selectedValue
                self.viewModel.updateText(for: type, updatedText: selectedValue)
            }
            picker.dataSource = self.pickerViewSecondaryRender
            picker.delegate = self.pickerViewSecondaryRender
            self.secondaryInputTextField.inputView = picker
        }
    }
    
    private func setSecondaryFlag(_ setFlag: Bool) {
        self.secondaryInputTextField.iconWidth = setFlag ? 30 : 0
        self.secondaryInputTextField.iconImage = setFlag ? UIImage(named: "flag") : nil
        self.secondaryInputTextField.isEnabled = !setFlag
        self.secondaryInputTextField.disabledColor = .themeBlueColor
    }
    
    @objc private func dateChanged(_ sender: UIDatePicker) {
        print(sender.date)
        self.requiredLabel.textColor = .lightGray
        self.inputTextField.text = sender.date.convertUTCToLocalInString()
        self.viewModel.updateStartDate(date: sender.date)
    }

    private func showSecondaryStack(_ isVisible: Bool) {
        self.secondaryStack.isHidden = !isVisible
        self.secondaryInputTextField.isEnabled = isVisible
    }
}

extension TextInputCell: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else { return true }

        guard self.viewModel.getCharacterCount(for: type) >= updatedString.count else {
            return false
        }

        self.viewModel.updateText(for: self.type, updatedText: updatedString)
        self.updateRequiredLabel(for: self.type, showError: true)
        if let floatingLabelTextField = textField as? SkyFloatingLabelTextField {
            switch self.type {
            case .formTitle, .startDate, .budget:
                if updatedString.isEmpty {
                    floatingLabelTextField.selectedLineColor = .red
                } else {
                    floatingLabelTextField.selectedLineColor = .lightGray
                }
            default:
                break
            }
        }
        return true
    }
}
