//
//  SQLiteStorageContext.swift
//  UKRSIB
//
//  Created by Valerii Sohlaiev on 30.09.2020.
//

import Foundation
import SQLite

/* Storage config options */
public enum ConfigurationType {
    case basic(url: String?)
    var associated: String? {
        get {
            switch self {
            case .basic(let url): return url
            }
        }
    }
}

class SQLiteStorageContext: StorageContext {
    
    let db : Connection
    let db_patch = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first! + "/db.sqlite3"
    
    required init(configuration: ConfigurationType = .basic(url: nil)) throws {
        
        self.db = try! Connection(db_patch)
        
        if tableExists(tableName: "CurrencyEntity") == 0 {
            try! db.run(CurrencyEntity.create { t in
                t.column(id, primaryKey: true)
                t.column(name)
                t.column(code, unique: true)
            })
        }
        
        if tableExists(tableName: "ExchangeEntity") == 0 {
            try! db.run(ExchangeEntity.create { t in
                t.column(currency_id)
                t.column(exchange_date)
                t.column(exchange_rate)
                t.unique(currency_id, exchange_date)
                t.foreignKey(currency_id, references: CurrencyEntity, id, delete: .setNull)
            })
        }
        
    }

}
