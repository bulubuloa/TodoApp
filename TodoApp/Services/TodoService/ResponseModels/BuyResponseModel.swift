//
//  BuyResponseModel.swift
//  TodoApp
//
//  Created by Omnimobile on 2/16/22.
//

import Foundation
struct BuyModel: Codable {
    let id: Int
    let name: String
    let price, quantity, type: Int
}

typealias BuyResponseModel = [BuyModel]
