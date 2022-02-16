//
//  BaseService.swift
//  TodoApp
//
//  Created by Omnimobile on 2/16/22.
//

import Foundation

class BaseService {
    lazy var webAPI: IWebAPI = {
        return WebAPI()
    }()
    
    lazy var itemToSellService: IItemToSellService = {
        return ItemToSellService()
    }()
}
