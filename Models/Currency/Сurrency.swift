//
//  Сurrency.swift
//  Models
//
//  Created by Valerii Sohlaiev on 30.09.2020.
//

import Foundation

public struct ExchangeModel: Codable {
    public let currency: [CurrencyModel]?
}

public struct CurrencyModel: Codable {
    public let r030: Int?
    public let txt: String?
    public let rate: Double?
    public let cc: String?
    public let exchangedate: String?
}

public struct Currency {
    public let id: Int
    public let name: String
    public let code: String
    
    public init(id: Int, name: String, code: String) {
        self.id = id
        self.name = name
        self.code = code
    }
}

public struct Exchange {
    public let currency_id: Int
    public let exchange_date: String
    public let exchange_rate: Double
    
    public init(currency_id: Int, exchange_date: String, exchange_rate: Double) {
        self.currency_id = currency_id
        self.exchange_date = exchange_date
        self.exchange_rate = exchange_rate
    }
}
