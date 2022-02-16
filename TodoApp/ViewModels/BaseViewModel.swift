//
//  BaseViewModel.swift
//  TodoApp
//
//  Created by Omnimobile on 2/16/22.
//

import Foundation
import RxSwift

class BaseViewModel: NSObject {
    var disposeBag = DisposeBag()
    
    lazy var todoService: ITodoService = {
      return TodoService()
    }()
}
