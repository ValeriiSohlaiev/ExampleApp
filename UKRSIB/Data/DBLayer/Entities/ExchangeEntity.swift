//
//  ExchangeEntity.swift
//  UKRSIB
//
//  Created by Valerii Sohlaiev on 01.10.2020.
//

import SQLite

let ExchangeEntity = Table("ExchangeEntity")
let currency_id    = Expression<Int>("currency_id")      // r030
let exchange_date  = Expression<String>("exchange_date") // exchangedate
let exchange_rate  = Expression<Double>("exchange_rate") // rate
