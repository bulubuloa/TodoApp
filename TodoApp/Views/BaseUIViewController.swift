//
//  BaseUIViewController.swift
//  TodoApp
//
//  Created by Omnimobile on 2/16/22.
//

import Foundation
import Foundation
import RxSwift
import UIKit

class BaseUIViewController : UIViewController {
    let disposeBag = DisposeBag()
    
    func setupUI() {
        
    }
    
    func setupBinding() {
        
    }
    
    override func viewDidLoad() {
        setupUI()
        setupBinding()
    }
    
    deinit {
        print("Dispose \(String(describing: self))")
    }
}
