//
//  DBLayerAPI.swift
//  UKRSIB
//
//  Created by Valerii Sohlaiev on 30.09.2020.
//

import Foundation
import SQLite
import Models

/*
 Operations on context
 */
protocol StorageContext {
    
    func count(model: Table) -> Int
    
    @discardableResult
    func addCurrency(r030: Int, txt: String, cc: String) -> Int64?
    
    func getCurrency() -> [Currency]
    
    @discardableResult
    func addExchange(r030: Int, exchangedate: String, rate: Double) -> Int64?
    
    func getExchange(date: String?) -> [Exchange]
    
}
