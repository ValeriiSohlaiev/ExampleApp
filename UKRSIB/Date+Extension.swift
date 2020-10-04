//
//  Date+Extension.swift
//  UKRSIB
//
//  Created by Valerii Sohlaiev on 02.10.2020.
//

import Foundation

extension Date {
    
    var ddMMyyyyString: String {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            return dateFormatter.string(from: self)
        }
    }
    
    var ddMMyyyyTime: String {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
            return dateFormatter.string(from: self)
        }
    }
    
}
