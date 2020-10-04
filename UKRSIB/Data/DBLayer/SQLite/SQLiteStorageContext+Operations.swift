//
//  SQLiteStorageContext+Operations.swift
//  UKRSIB
//
//  Created by Valerii Sohlaiev on 01.10.2020.
//

import Foundation
import Models
import SQLite

extension SQLiteStorageContext {
    
    func tableExists(tableName name: String) -> Int64 {
        return try! db.scalar("SELECT EXISTS(SELECT name FROM sqlite_master WHERE name = ?)", name) as! Int64
    }
    
    func count(model: Table) -> Int {
        return try! db.scalar(model.count)
    }
    
    // Currency
    @discardableResult
    func addCurrency(r030: Int, txt: String, cc: String) -> Int64? {
        do {
            guard try db.scalar(CurrencyEntity.where(id == r030).count) == 0 else { return -1 }
            let insert = CurrencyEntity.insert(id <- r030, name <- txt, code <- cc)
            return try db.run(insert)
        } catch {
            return -1
        }
    }
    
    func getCurrency() -> [Currency] {
        var currency = [Currency]()
        do {
            for item in try db.prepare(CurrencyEntity) {
                currency.append(Currency(id: item[id], name: item[name], code: item[code]))
            }
        } catch {
            print("Select failed")
        }
        return currency
    }
    
    // Exchange
    @discardableResult
    func addExchange(r030: Int, exchangedate: String, rate: Double) -> Int64? {
        do {
            if try db.scalar(ExchangeEntity.where(currency_id == r030 && exchange_date == exchangedate).count) == 0 {
                let insert = ExchangeEntity.insert(currency_id <- r030, exchange_date <- exchangedate, exchange_rate <- rate)
                return try db.run(insert)
            } else {
                let alice = ExchangeEntity.filter(currency_id == r030 && exchange_date == exchangedate)
                try db.run(alice.update(exchange_rate <- rate))
                return 0
            }
        } catch {
            return -1
        }
    }
    
    func getExchange(date: String? = nil) -> [Exchange] {
        var exchange = [Exchange]()
        do {
            for item in try db.prepare(ExchangeEntity) {
                exchange.append(Exchange(currency_id: item[currency_id],
                                         exchange_date: item[exchange_date],
                                         exchange_rate: item[exchange_rate]))
            }
        } catch {
            print("Select failed")
        }
        return exchange.filter({ $0.exchange_date == date ?? Date().ddMMyyyyString })
    }
    
}
