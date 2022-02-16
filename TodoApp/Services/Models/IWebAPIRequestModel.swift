//
//  IWebAPIRequestModel.swift
//  TodoApp
//
//  Created by Omnimobile on 2/16/22.
//

import Foundation

typealias RequestModel = [String: Any]

protocol IWebAPIRequestModel : Encodable {
    func getParameters() -> RequestModel?
}

extension IWebAPIRequestModel {
    func getParameters() -> RequestModel? {
        do {
            let data = try? JSONEncoder.init().encode(self)
            guard let data = data else {
                return nil
            }
            let dictionary = try? JSONSerialization.jsonObject(with: data) as? RequestModel
            return dictionary
        } catch {
            return nil
        }
    }
}
