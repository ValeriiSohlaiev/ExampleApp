//
//  DB.swift
//  UKRSIB
//
//  Created by Valerii Sohlaiev on 30.09.2020.
//

import Foundation
import SQLite

class DB {
    static var storage: StorageContext? {
        get {
            return try? SQLiteStorageContext(configuration: .basic(url: nil))
        }
    }
}

