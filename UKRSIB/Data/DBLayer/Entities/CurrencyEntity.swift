//
//  CurrencyEntity.swift
//  UKRSIB
//
//  Created by Valerii Sohlaiev on 01.10.2020.
//

import SQLite

let CurrencyEntity = Table("CurrencyEntity")
let id             = Expression<Int>("id")       // r030
let name           = Expression<String>("name")  // txt
let code           = Expression<String>("code")  // cc
