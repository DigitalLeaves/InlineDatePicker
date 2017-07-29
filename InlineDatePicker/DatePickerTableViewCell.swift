//
//  DatePickerTableViewCell.swift
//  InlineDatePicker
//
//  Created by Ignacio Nieto Carvajal on 11/1/17.
//  Copyright © 2017 Ignacio Nieto Carvajal. All rights reserved.
//

import UIKit

protocol DatePickerTableViewCellDelegate: class {
    func dateChangedForField(field: ModelFieldType, toDate date: Date)
}

class DatePickerTableViewCell: UITableViewCell {
    // outlets
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // data
    var field: ModelFieldType!
    weak var delegate: DatePickerTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureWithField(field: ModelFieldType, currentDate: Date?) {
        self.field = field
        self.datePicker.date = currentDate ?? Date()
    }

    @IBAction func datePickerValueChanged(_ sender: Any) {
        self.delegate?.dateChangedForField(field: field, toDate: datePicker.date)
    }
    
}
