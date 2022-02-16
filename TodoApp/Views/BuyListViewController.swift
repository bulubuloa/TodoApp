//
//  BuyListViewController.swift
//  TodoApp
//
//  Created by Omnimobile on 2/16/22.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

class BuyListViewController: BaseUIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = BuyListViewModel()
    
    override func setupUI() {
        tableView.register(UINib(nibName: CellContansts.BuyCellNib, bundle: nil), forCellReuseIdentifier: CellContansts.BuyCellID)
    }
    
    override func setupBinding() {
        let parameterRelay = BehaviorRelay<BuyRequestModel>(value: BuyRequestModel())
        
        let input = BuyListViewModel.Input(queryParameter: parameterRelay)
        let output = viewModel.makeBinding(input: input)
        
        output.result
            .bind(to: tableView.rx.items(cellIdentifier: CellContansts.BuyCellID, cellType: BuyTableViewCell.self)) {
                row, element, cell in
                
                cell.txt1.text = element.name
                cell.txt2.text = "\(element.price)"
                cell.txt3.text = "\(element.quantity)"
            }
            .disposed(by: disposeBag)
    }
}
