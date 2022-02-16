//
//  SellListViewController.swift
//  TodoApp
//
//  Created by Omnimobile on 2/16/22.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

class SellListViewController: BaseUIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = SellListViewModel()
    
    override func setupUI() {
        tableView.register(UINib(nibName: CellContansts.BuyCellNib, bundle: nil), forCellReuseIdentifier: CellContansts.BuyCellID)
    }
    
    override func setupBinding() {
        //test
        exampleData()
        
        let parameterRelay = BehaviorRelay<SellRequestModel>(value: SellRequestModel())
        
        let input = SellListViewModel.Input(queryParameter: parameterRelay)
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
    
    func exampleData() {
        let service = ItemToSellService()
        service.addItem(id: 3, name: "Table", price: 12000, quantity: 1, type: 2).subscribe(
            onSuccess: {
                result in
                print(result)
            }
        ).disposed(by: disposeBag)
        service.addItem(id: 2, name: "TV", price: 38000, quantity: 2, type: 2).subscribe(
            onSuccess: {
                result in
                print(result)
            }
        ).disposed(by: disposeBag)
    }
}
