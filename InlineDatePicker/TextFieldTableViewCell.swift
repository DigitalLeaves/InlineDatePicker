//
//  TextFieldTableViewCell.swift
//  InlineDatePicker
//
//  Created by Ignacio Nieto Carvajal on 11/1/17.
//  Copyright © 2017 Ignacio Nieto Carvajal. All rights reserved.
//

import UIKit

protocol TextFieldTableViewCellDelegate: class {
    func fieldDidBeginEditing(field: ModelFieldType)
    func field(field: ModelFieldType, changedValueTo value: String)
}

class TextFieldTableViewCell: UITableViewCell, UITextFieldDelegate {
    // outlets
    @IBOutlet weak var fieldNameLabel: UILabel!
    @IBOutlet weak var fieldValueTextfield: UITextField!

    // data
    var field: ModelFieldType!
    weak var delegate: TextFieldTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        fieldValueTextfield.delegate = self
    }
    
    @IBAction func valueChanged(_ sender: UITextField) {
        self.delegate?.field(field: field, changedValueTo: sender.text ?? "")
    }
    
    func configureWithField(field: ModelFieldType, andValue value: String?, editable: Bool) {
        self.field = field
        self.fieldNameLabel.text = self.field.rawValue
        self.fieldValueTextfield.text = value ?? ""
        
        if editable {
            self.fieldValueTextfield.isUserInteractionEnabled = true
            self.selectionStyle = .none
        } else {
            self.fieldValueTextfield.isUserInteractionEnabled = false
            self.selectionStyle = .default
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.delegate?.fieldDidBeginEditing(field: field)
    }
}
