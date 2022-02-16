//
//  MainMenuViewController.swift
//  TodoApp
//
//  Created by Omnimobile on 2/16/22.
//

import UIKit
import RxCocoa
import RxSwift

class MainMenuViewController: BaseUIViewController {

    @IBOutlet weak var bttCall: UIButton!
    @IBOutlet weak var bttBuy: UIButton!
    @IBOutlet weak var bttSell: UIButton!
    
    override func setupBinding() {
        bttCall.rx.tap.subscribe(
            onNext: { [unowned self]
                item in
                let vc = storyboard?.instantiateViewController(withIdentifier: ViewConstants.CallListViewController) as! CallListViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        ).disposed(by: disposeBag)
        
        bttBuy.rx.tap.subscribe(
            onNext: { [unowned self]
                item in
                let vc = storyboard?.instantiateViewController(withIdentifier: ViewConstants.BuyListViewController) as! BuyListViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        ).disposed(by: disposeBag)
        
        bttSell.rx.tap.subscribe(
            onNext: { [unowned self]
                item in
                let vc = storyboard?.instantiateViewController(withIdentifier: ViewConstants.SellListViewController) as! SellListViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        ).disposed(by: disposeBag)
    }
}
