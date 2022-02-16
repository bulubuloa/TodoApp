//
//  CallListViewController.swift
//  TodoApp
//
//  Created by Omnimobile on 2/16/22.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

class CallListViewController: BaseUIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = CallListViewModel()
    
    override func setupUI() {
        tableView.register(UINib(nibName: CellContansts.CallCellNib, bundle: nil), forCellReuseIdentifier: CellContansts.CallCellID)
    }
    
    override func setupBinding() {
        let parameterRelay = BehaviorRelay<CallRequestModel>(value: CallRequestModel())
        
        let input = CallListViewModel.Input(queryParameter: parameterRelay)
        let output = viewModel.makeBinding(input: input)
        
        output.result
            .bind(to: tableView.rx.items(cellIdentifier: CellContansts.CallCellID, cellType: CallTableViewCell.self)) {
                row, element, cell in
                
                cell.txt1.text = element.name
                cell.txt2.text = element.number
            }
            .disposed(by: disposeBag)
    }
}
