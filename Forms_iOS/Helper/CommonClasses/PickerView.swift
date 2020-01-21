//
//  PickerView.swift
//  Forms_iOS
//
//  Created by Soumya Jain on 21/01/20.
//  Copyright © 2020 Soumya. All rights reserved.
//

import UIKit

class PickerViewRender: NSObject, UIPickerViewDataSource {
    
    var listToPopulate: [String]
    var type: FormDetailsTypes
    var selectedValue: ((_ selectedValue: String, _ type: FormDetailsTypes) -> Void)?
    
    init(array: [String], type: FormDetailsTypes) {
        self.listToPopulate = array
        self.type = type
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        switch pickerView.tag {
//        case FieldType.primary.rawValue:
//            return self.primaryList.count
//        case FieldType.secondary.rawValue:
//            return self.secondaryList.count
//        default:
//            return 0
//        }
        return self.listToPopulate.count
    }
}

extension PickerViewRender: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        switch pickerView.tag {
//        case FieldType.primary.rawValue:
//            return self.primaryList[row]
//        case FieldType.secondary.rawValue:
//            return self.secondaryList[row]
//        default:
//            return ""
//        }
        return self.listToPopulate[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        var selectedValue = ""
//        var selectedType = self.type
//        switch pickerView.tag {
//        case FieldType.primary.rawValue:
//            selectedValue = self.primaryList[row]
//        case FieldType.secondary.rawValue:
//            selectedValue = self.secondaryList[row]
//            guard let relatedType = self.viewModel.getRelatedSecondaryType(for: type) else { break }
//            selectedType = relatedType
//        default:
//            break
//        }
//        self.secondaryInputTextField.text = selectedValue
//        self.viewModel.updateText(for: selectedType!, updatedText: selectedValue)
        
        self.selectedValue?(self.listToPopulate[row], self.type)
    }
}
