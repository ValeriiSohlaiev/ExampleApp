//
//  CurrencyDetail.swift
//  UKRSIB
//
//  Created by Valerii Sohlaiev on 02.10.2020.
//
import UIKit

class CurrencyDetail: UIViewController {
    
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var date_rate: UILabel!
    
    var viewModel: CurrencyDetailViewModelType? 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }
    
    func updateView() {
        guard let viewModel = viewModel else { return }
        rate.text = String(format:"%.5f", viewModel.rate ?? 0.0)
        date_rate.text = viewModel.date
    }

}
