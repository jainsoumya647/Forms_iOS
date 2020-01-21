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

    enum FieldType: Int {
        case primary
        case secondary
    }

    @IBOutlet weak var inputTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var secondaryInputTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var requiredLabel: UILabel!
    @IBOutlet weak var secondaryStack: UIStackView!

    var type: FormDetailsTypes!
    var viewModel: FormDetailsViewModel!
    var primaryList = [String]()
    var secondaryList = [String]()

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
        case .currency:
            self.inputTextField.keyboardType = .numberPad
            self.showSecondaryStack(true)
            self.secondaryInputTextField.iconWidth = 30
            self.secondaryInputTextField.iconType = .image
            self.secondaryInputTextField.iconImage = UIImage(named: "flag")
            self.secondaryInputTextField.isEnabled = false
            self.secondaryInputTextField.disabledColor = .themeBlueColor
        case .rate:
            self.showSecondaryStack(true)
            self.secondaryInputTextField.iconWidth = 0
            self.secondaryInputTextField.iconImage = nil
            self.secondaryInputTextField.isEnabled = true
            self.primaryList = self.viewModel.getPickerArray(for: type)
            let picker = UIPickerView()
            picker.tag = FieldType.primary.rawValue
            picker.dataSource = self
            picker.delegate = self
            self.inputTextField.inputView = picker
        case .paymentMethod:
            self.showSecondaryStack(true)
            self.secondaryInputTextField.iconWidth = 0
            self.secondaryInputTextField.iconImage = nil
            self.secondaryInputTextField.isEnabled = true
            self.secondaryList = self.viewModel.getPickerArray(for: type)
            let picker = UIPickerView()
            picker.tag = FieldType.secondary.rawValue
            picker.dataSource = self
            picker.delegate = self
            self.secondaryInputTextField.inputView = picker
        case .jobTerm:
            self.showSecondaryStack(true)
            self.secondaryInputTextField.iconWidth = 0
            self.secondaryInputTextField.iconImage = nil
            self.secondaryInputTextField.isEnabled = true
            self.secondaryList = self.viewModel.getPickerArray(for: type)
            let picker = UIPickerView()
            picker.tag = FieldType.secondary.rawValue
            picker.dataSource = self
            picker.delegate = self
            self.secondaryInputTextField.inputView = picker
        case .startDate:
            self.showSecondaryStack(true)
            self.secondaryInputTextField.iconWidth = 0
            self.secondaryInputTextField.iconImage = nil
            self.secondaryInputTextField.isEnabled = true
            let picker = UIDatePicker()
            picker.tag = FieldType.primary.rawValue
            picker.datePickerMode = .date
            picker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
            self.inputTextField.inputView = picker
        default:
            self.showSecondaryStack(true)
            self.secondaryInputTextField.iconWidth = 0
            self.secondaryInputTextField.iconImage = nil
            self.secondaryInputTextField.isEnabled = true
        }
    }

    @objc private func dateChanged(_ sender: UIDatePicker) {
        print(sender.date)
        let dateInStringFormat = sender.date.convertUTCToLocalInString()
        self.inputTextField.text = dateInStringFormat
        self.viewModel.updateText(for: self.type, updatedText: dateInStringFormat)
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

extension TextInputCell: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case FieldType.primary.rawValue:
            return self.primaryList.count
        case FieldType.secondary.rawValue:
            return self.secondaryList.count
        default:
            return 0
        }
    }
}

extension TextInputCell: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case FieldType.primary.rawValue:
            return self.primaryList[row]
        case FieldType.secondary.rawValue:
            return self.secondaryList[row]
        default:
            return ""
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var selectedValue = ""
        var selectedType = self.type
        switch pickerView.tag {
        case FieldType.primary.rawValue:
            selectedValue = self.primaryList[row]
        case FieldType.secondary.rawValue:
            selectedValue = self.secondaryList[row]
            guard let relatedType = self.viewModel.getRelatedSecondaryType(for: type) else { break }
            selectedType = relatedType

        default:
            break
        }
        self.secondaryInputTextField.text = selectedValue
        self.viewModel.updateText(for: selectedType!, updatedText: selectedValue)
    }
}
