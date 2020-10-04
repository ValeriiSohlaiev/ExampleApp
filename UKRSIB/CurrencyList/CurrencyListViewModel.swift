//
//  CurrencyListViewModel.swift
//  UKRSIB
//
//  Created by Valerii Sohlaiev on 02.10.2020.
//

import Foundation
import Models

protocol CurrencyListViewModelType {
    
    var ifNeedUpdateData: Box<Bool> { get set }
    
    func numberOfRows() -> Int?
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelType?
    
    func viewModelForSelectedRow() -> CurrencyDetailViewModelType?
    func selectRow(atIndexPath indexPath: IndexPath)
    func selectDate(date: String)
}

class CurrencyListViewModel: CurrencyListViewModelType {

    var ifNeedUpdateData: Box<Bool> = Box(false)
    
    private var selectedIndexPath: IndexPath?
    private var currencys: [Currency]?
    private var exchanges: [Exchange]?
    
    init() {
        ExchangeApi.currency { (succes, data, error) in
            self.currencys = DB.storage?.getCurrency()
            self.exchanges = DB.storage?.getExchange(date: nil)
            self.ifNeedUpdateData.value = true
        }
        currencys = DB.storage?.getCurrency()
        exchanges = DB.storage?.getExchange(date: nil)
    }
    
    func numberOfRows() -> Int? {
        return currencys?.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelType? {
        let currency = currencys?[indexPath.row]
        return TableViewCellViewModel(currency: currency)
    }
    
    func viewModelForSelectedRow() -> CurrencyDetailViewModelType? {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        guard let currency = currencys?[selectedIndexPath.row] else { return nil }
        return CurrencyDetailViewModel(exchange: exchanges?.filter({ $0.currency_id == currency.id }).first )
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
    func selectDate(date: String) {
        exchanges = DB.storage?.getExchange(date: date)
    }
}
