//
//  ItemToSellService.swift
//  TodoApp
//
//  Created by Omnimobile on 2/16/22.
//

import Foundation
import RxSwift


protocol IItemToSellService {
    func addItem(id: Int, name: String, price: Int, quantity: Int, type: Int) -> Single<Bool>
    func fetchAll() -> Single<SellResponseModel>
}

class ItemToSellService: IItemToSellService {
    
    lazy var coreData: CoreDataManager = {
       return CoreDataManager(module: "TodoDBModel")
    }()
    
    func addItem(id: Int, name: String, price: Int, quantity: Int, type: Int) -> Single<Bool> {
        let singleReturn = Single<Bool>.create { [weak self]
            single in
            
            if let self = self {
                let model = ItemToSell(context: self.coreData.mainContext)
                model.id = Int16(id)
                model.name = name
                model.price = Int32(price)
                model.quantity = Int16(quantity)
                model.type = Int16(type)
                
                let result = self.coreData.saveChanges()
                single(.success(result))
            } else {
                single(.success(false))
            }
            
            return Disposables.create() {
            }
        }
        return singleReturn
    }
    
    func fetchAll() -> Single<SellResponseModel> {
        let singleReturn = Single<SellResponseModel>.create { [weak self]
            single in
            
            do {
                let items = try self?.coreData.mainContext.fetch(ItemToSell.fetchRequest())
                if let result = items {
                    single(.success(result))
                } else {
                    single(.success([]))
                }
            } catch {
                single(.failure(CoreDataError.feetchError))
            }

            return Disposables.create() {
            }
        }
        return singleReturn
    }
}
