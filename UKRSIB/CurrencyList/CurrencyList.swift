//
//  CurrencyList.swift
//  UKRSIB
//
//  Created by Valerii Sohlaiev on 30.09.2020.
//

import UIKit

class CurrencyList: UIViewController {

    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var choiceDate: UIBarButtonItem!
    
    private var viewModel: CurrencyListViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = UserDefaults.standard.string(forKey: "LastUpdate")
        
        detailView.isHidden = !(UIDevice.current.orientation.isLandscape)
        choiceDate.title = Date().ddMMyyyyString
        tableView.register(UINib(nibName: CurrencyCell.stringName, bundle: nil), forCellReuseIdentifier: CurrencyCell.stringName)
        tableView.reloadData()
        
        viewModel = CurrencyListViewModel()
        viewModel?.ifNeedUpdateData.bind { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
    
    @IBAction func choiceDateAction(_ sender: Any) {
        let alertController = UIAlertController(title: "\n\n", message: nil, preferredStyle: .alert)
        let myDatePicker: UIDatePicker = UIDatePicker()
        myDatePicker.locale = Locale(identifier: "ru")
        myDatePicker.datePickerMode = .date
        myDatePicker.frame = CGRect(x: 10, y: 15, width: 250, height: 50)
        alertController.view.addSubview(myDatePicker)
        
        let selectAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
            self.choiceDate.title = myDatePicker.date.ddMMyyyyString
            self.viewModel?.selectDate(date: myDatePicker.date.ddMMyyyyString)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(selectAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        detailView.isHidden = !(UIDevice.current.orientation.isLandscape)
        updateCurrencyDetail()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == CurrencyDetail.stringName {
            if let vc = segue.destination as? CurrencyDetail {
                vc.viewModel = viewModel?.viewModelForSelectedRow()
            }
        }
    }

}

// MARK: - UITableView Delegat
extension CurrencyList: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Identifier = CurrencyCell.stringName
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier, for: indexPath) as! CurrencyCell
        let cellViewModel = viewModel?.cellViewModel(forIndexPath: indexPath)
        
        cell.viewModel = cellViewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        viewModel.selectRow(atIndexPath: indexPath)
        if UIDevice.current.orientation.isPortrait {
            performSegue(withIdentifier: CurrencyDetail.stringName, sender: nil)
        } else {
            updateCurrencyDetail()
        }
    }
    
    func updateCurrencyDetail() {
        if let vc = children[0] as? CurrencyDetail {
            vc.viewModel = viewModel?.viewModelForSelectedRow()
            vc.updateView()
        }
    }
    
}
