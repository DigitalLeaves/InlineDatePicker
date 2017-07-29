//
//  Person.swift
//  CustomSplitControl
//
//  Created by Ignacio Nieto Carvajal on 3/1/17.
//  Copyright © 2017 Ignacio Nieto Carvajal. All rights reserved.
//

import UIKit

enum ModelFieldType: String {
    case name = "name"
    case email = "email"
    case startedWorkDate = "started work date"
    case endedWorkDate = "ended work date"
    case phoneNumber = "phone number"
    case image = "image"
    case maritalStatus = "marital status"
    case address = "address"
    case userId = "user Id"
    case password = "password"
}

class Person: NSObject {
    // credentials
    var userId: String
    var password: String
    
    // personal information
    var name: String!
    var email: String!
    var startedWorkDate: Date!
    var endedWorkDate: Date!
    var phoneNumber: String!
    var image: UIImage!
    var maritalStatus: String!
    
    // location
    var address: String!
    
    init(userId: String, password: String, name: String!, email: String!, startedWorkDate: Date!, endedWorkDate: Date!, phoneNumber: String!, image: UIImage!, maritalStatus: String!, address: String!) {
        self.userId = userId
        self.password = password
        self.name = name
        self.email = email
        self.startedWorkDate = startedWorkDate
        self.endedWorkDate = endedWorkDate
        self.phoneNumber = phoneNumber
        self.image = image
        self.maritalStatus = maritalStatus
        self.address = address
    }
    
    func valueForField(field: ModelFieldType) -> Any {
        switch field {
        case .name: return name
        case .email: return email
        case .startedWorkDate: return startedWorkDate
        case .endedWorkDate: return endedWorkDate
        case .phoneNumber: return phoneNumber
        case .image: return image
        case .maritalStatus: return maritalStatus
        case .address: return address
        case .userId: return userId
        case .password: return password
        }
    }
    
    func stringValueForField(field: ModelFieldType) -> String {
        if field == .startedWorkDate {
            guard let date = startedWorkDate else { return "-" }
            return Person.dateStringFromDate(date: date)
        } else if field == .endedWorkDate {
            guard let date = endedWorkDate else { return "-" }
            return Person.dateStringFromDate(date: date)
        } else { return valueForField(field: field) as? String ?? "-" }
    }
    
    func setValue(value: Any, forField field: ModelFieldType) {
        switch field {
        case .name: if let name = value as? String { self.name = name }
        case .email: if let email = value as? String { self.email = email }
        case .startedWorkDate:
            if let startedWorkDate = value as? Date { self.startedWorkDate = startedWorkDate }
            else if let swString = value as? String, let swFromString = Person.dateFromString(dateString: swString) { self.startedWorkDate = swFromString }
        case .endedWorkDate:
            if let endedWorkDate = value as? Date { self.endedWorkDate = endedWorkDate }
            else if let ewString = value as? String, let ewFromString = Person.dateFromString(dateString: ewString) { self.endedWorkDate = ewFromString }
        case .phoneNumber: if let phoneNumber = value as? String { self.phoneNumber = phoneNumber }
        case .image: if let image = value as? UIImage { self.image = image }
        case .maritalStatus: if let maritalStatus = value as? String { self.maritalStatus = maritalStatus }
        case .address: if let address = value as? String { self.address = address }
        case .userId: if let userId = value as? String { self.userId = userId }
        case .password: if let password = value as? String { self.password = password }
        }
    }
    
    // MARK: - Hashable/Equatable
    override var hash: Int { return userId.hash }
    override var hashValue: Int { return userId.hashValue }
    override func isEqual(_ object: Any?) -> Bool {
        guard let otherPerson = object as? Person else { return false }
        return otherPerson == self
    }
    
    static var _dateFormatter: DateFormatter?
    fileprivate static var dateFormatter: DateFormatter {
        if (_dateFormatter == nil) {
            _dateFormatter = DateFormatter()
            _dateFormatter!.locale = Locale(identifier: "en_US_POSIX")
            _dateFormatter!.dateFormat = "MM/dd/yyyy"
        }
        return _dateFormatter!
    }
    static func dateFromString(dateString: String) -> Date? {
        return dateFormatter.date(from: dateString)
    }
    static func dateStringFromDate(date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    // description
    override var description: String {
        return "Person. Name: \(name), email: \(email), phone: \(phoneNumber),  "
    }
}

func ==(lhs: Person, rhs: Person) -> Bool {
    return lhs.userId == rhs.userId
}


