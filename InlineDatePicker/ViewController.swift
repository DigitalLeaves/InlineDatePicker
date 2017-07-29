//
//  ViewController.swift
//  InlineDatePicker
//
//  Created by Ignacio Nieto Carvajal on 11/1/17.
//  Copyright © 2017 Ignacio Nieto Carvajal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DatePickerTableViewCellDelegate, TextFieldTableViewCellDelegate {
    // outlets
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var personImageView: UIImageView!
    
    // data
    let person = Person(userId: "aw8v9w7fh3978vh",
                        password: "AllYourP4ssw0rdsAr3BelongToU5",
                        name: "Anne White",
                        email: "annewhite123@example.com",
                        startedWorkDate: Person.dateFromString(dateString: "04/01/1995"),
                        endedWorkDate: Person.dateFromString(dateString: "06/15/2001"),
                        phoneNumber: "+1(202)123-4567",
                        image: UIImage(named: "anneWhite"),
                        maritalStatus: "single",
                        address: "123rd Fake Street N, Tacoma, WA 98765, US")
    let fields: [ModelFieldType] = [.name, .email, .startedWorkDate, .endedWorkDate, .phoneNumber, .maritalStatus, .address]
    let dateFields: [ModelFieldType] = [.startedWorkDate, .endedWorkDate]
    
    // datepicker related data
    var datePickerIndexPath: IndexPath?
    var datePickerVisible: Bool { return datePickerIndexPath != nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // load the different cells for our table view
        tableView.register(UINib(nibName: "DatePickerTableViewCell", bundle: nil), forCellReuseIdentifier: "DatePickerTableViewCell")
        tableView.register(UINib(nibName: "TextFieldTableViewCell", bundle: nil), forCellReuseIdentifier: "TextFieldTableViewCell")

        // cell height for table view rows
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // appearance
        personImageView.layer.borderColor = UIColor.lightGray.cgColor
        personImageView.layer.borderWidth = 3
        personImageView.layer.masksToBounds = true
        personImageView.layer.cornerRadius = personImageView.frame.width / 2.0
        personImageView.image = self.person.image
    }

    // MARK: - UITableViewDataSource/Delegate methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // if our date picker is visible, add one to the list of fields for row count.
        return datePickerVisible ? fields.count + 1 : fields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // date picker?
        if datePickerVisible && datePickerIndexPath! == indexPath {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "DatePickerTableViewCell", for: indexPath) as! DatePickerTableViewCell
            cell.delegate = self

            // the field will correspond to the index of the row before this one.
            let field = fields[indexPath.row - 1]
            cell.configureWithField(field: field, currentDate: person.valueForField(field: field) as? Date)
            
            return cell
            
        } else {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "TextFieldTableViewCell", for: indexPath) as! TextFieldTableViewCell

            cell.delegate = self
            let field = calculateFieldForIndexPath(indexPath: indexPath)
            cell.configureWithField(field: field, andValue: person.stringValueForField(field: field), editable: !dateFields.contains(field))
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if !datePickerShouldAppearForRowSelectionAtIndexPath(indexPath: indexPath) {
            dismissDatePickerRow()
            return
        }
        
        self.view.endEditing(true)
        tableView.beginUpdates()
        if datePickerVisible {
            // close datepicker
            tableView.deleteRows(at: [datePickerIndexPath!], with: .fade)
            let oldDatePickerIndexPath = datePickerIndexPath!
            
            if datePickerIsRightBelowMe(indexPath: indexPath) {
                // just close the datepicker
                self.datePickerIndexPath = nil
            } else {
                // open it my new location
                let newRow = oldDatePickerIndexPath.row < indexPath.row ? indexPath.row : indexPath.row + 1
                self.datePickerIndexPath = IndexPath(row: newRow, section: indexPath.section)
                tableView.insertRows(at: [self.datePickerIndexPath!], with: .fade)
            }
        } else {
            self.datePickerIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
            tableView.insertRows(at: [self.datePickerIndexPath!], with: .fade)
        }
        tableView.endUpdates()
    }
    
    // MARK: - Date picker operations and index calculations
    
    func calculateFieldForIndexPath(indexPath: IndexPath) -> ModelFieldType {
        if datePickerVisible && datePickerIndexPath!.section == indexPath.section {
            if datePickerIndexPath!.row == indexPath.row { // we are the date picker. Pick the field below me
                return fields[indexPath.row - 1]
            } else if datePickerIndexPath!.row > indexPath.row { // we are "below" the date picker. Just return the field.
                return fields[indexPath.row]
            } else { // we are above the datePicker, so we should substract one from the current row index.
                return fields[indexPath.row - 1]
            }
        } else {
            // The date picker is not showing or not in my section, just return the usual field.
            return fields[indexPath.row]
        }
    }
    
    func datePickerIsRightAboveMe(indexPath: IndexPath) -> Bool {
        if datePickerVisible && datePickerIndexPath!.section == indexPath.section {
            if indexPath.section != datePickerIndexPath!.section { return false }
            else { return indexPath.row == datePickerIndexPath!.row + 1 }
        } else { return false }
    }
    
    func datePickerIsRightBelowMe(indexPath: IndexPath) -> Bool {
        if datePickerVisible && datePickerIndexPath!.section == indexPath.section {
            if indexPath.section != datePickerIndexPath!.section { return false }
            else { return indexPath.row == datePickerIndexPath!.row - 1 }
        } else { return false }
    }
    
    func dismissDatePickerRow() {
        if !datePickerVisible { return }
        
        tableView.beginUpdates()
        tableView.deleteRows(at: [datePickerIndexPath!], with: .fade)
        datePickerIndexPath = nil
        tableView.endUpdates()
    }
    
    func datePickerShouldAppearForRowSelectionAtIndexPath(indexPath: IndexPath) -> Bool {
        let field = calculateFieldForIndexPath(indexPath: indexPath)
        return dateFields.contains(field)
    }
    
    // MARK: - DatePickerTableViewCellDelegate methods
    
    func dateChangedForField(field: ModelFieldType, toDate date: Date) {
        print("Date changed for field \(field) to \(date)")
        person.setValue(value: date, forField: field)
        self.tableView.reloadData()
    }
    
    // MARK: - TextFieldTableViewCellDelegate
    
    func field(field: ModelFieldType, changedValueTo value: String) {
        print("Value changed for field \(field) to \(value)")
        person.setValue(value: value, forField: field)
        self.tableView.reloadData()
    }
    
    func fieldDidBeginEditing(field: ModelFieldType) {
        dismissDatePickerRow()
    }
}

