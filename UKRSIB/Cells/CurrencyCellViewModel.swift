//
//  CurrencyCellViewModel.swift
//  UKRSIB
//
//  Created by Valerii Sohlaiev on 02.10.2020.
//

import Foundation
import Models

protocol TableViewCellViewModelType: class {
    var code: String? { get }
    var name: String? { get }
}

class TableViewCellViewModel: TableViewCellViewModelType {
    
    private var currency: Currency?
    
    var code: String? {
        return currency?.code
    }
    var name: String? {
        return currency?.name
    }
    
    init(currency: Currency?) {
        self.currency = currency
    }
}
