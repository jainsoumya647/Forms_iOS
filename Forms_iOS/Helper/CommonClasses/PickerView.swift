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
        return self.listToPopulate.count
    }
}

extension PickerViewRender: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.listToPopulate[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedValue?(self.listToPopulate[row], self.type)
    }
}
