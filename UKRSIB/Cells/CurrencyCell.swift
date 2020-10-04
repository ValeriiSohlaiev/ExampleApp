//
//  CurrencyCell.swift
//  UKRSIB
//
//  Created by Valerii Sohlaiev on 02.10.2020.
//

import UIKit
import Models

class CurrencyCell: UITableViewCell {
    
    @IBOutlet weak var code: UILabel!
    @IBOutlet weak var name: UILabel!
    
    weak var viewModel: TableViewCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            code.text = viewModel.code
            name.text = viewModel.name
        }
    }
    
}
