//
//  TodoService.swift
//  TodoApp
//
//  Created by Omnimobile on 2/16/22.
//

import Foundation
import RxSwift

protocol ITodoService {
    func getToCall(parameter: CallRequestModel) -> Single<CallResponseModel>
    func getToBuy(parameter: BuyRequestModel) -> Single<BuyResponseModel>
    func getToSell(parameter: SellRequestModel) -> Single<SellResponseModel>
}

class TodoService: BaseService, ITodoService {
    func getToSell(parameter: SellRequestModel) -> Single<SellResponseModel> {
        let ob: Single<SellResponseModel> = itemToSellService.fetchAll()
        return ob
    }
    
    func getToCall(parameter: CallRequestModel) -> Single<CallResponseModel> {
        let endpoint = TodoAPIRoute.call.endpointPath
        let ob: Single<CallResponseModel> = webAPI.request(method: .get, enpoint: endpoint, requestModel: parameter)
        return ob
    }
    
    func getToBuy(parameter: BuyRequestModel) -> Single<BuyResponseModel> {
        let endpoint = TodoAPIRoute.buy.endpointPath
        let ob: Single<BuyResponseModel> = webAPI.request(method: .get, enpoint: endpoint, requestModel: parameter)
        return ob
    }
}
