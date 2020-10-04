//
//  CurrencyDetailViewModel.swift
//  UKRSIB
//
//  Created by Valerii Sohlaiev on 02.10.2020.
//

import Foundation
import Models

protocol CurrencyDetailViewModelType: class {
    var rate: Double? { get }
    var date: String? { get }
}

class CurrencyDetailViewModel: CurrencyDetailViewModelType {

    private var exchange: Exchange?
    
    var rate: Double? {
        return exchange?.exchange_rate
    }
    
    var date: String? {
        return exchange?.exchange_date
    }
    
    init(exchange: Exchange?) {
        self.exchange = exchange
    }
}
