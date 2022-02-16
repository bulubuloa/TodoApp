//
//  CallResponseModel.swift
//  TodoApp
//
//  Created by Omnimobile on 2/16/22.
//

import Foundation
struct CallModel: Codable {
    let id: Int
    let name, number: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name, number
    }
}

typealias CallResponseModel = [CallModel]
