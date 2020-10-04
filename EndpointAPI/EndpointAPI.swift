//
//  EndpointAPI.swift
//  EndpointAPI
//
//  Created by Valerii Sohlaiev on 30.09.2020.
//

import Foundation

public struct Api {

    public static var baseUrl = "https://bank.gov.ua"
    
    public struct NBUStatService {
        public static let URL = "/NBUStatService/v1/statdirectory/exchange"
    }

}
