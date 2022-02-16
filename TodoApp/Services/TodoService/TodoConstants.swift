//
//  TodoConstants.swift
//  TodoApp
//
//  Created by Omnimobile on 2/16/22.
//

import Foundation
struct TodoConstants {
    static let TodoAPIEndpoint = "https://my-json-server.typicode.com/imkhan334/demo-1"
}

enum TodoAPIRoute {
    case call
    case buy
}

extension TodoAPIRoute {
    var apiPath: String {
        switch self {
        case .call:
            return "/call"
        case .buy:
            return "/buy"
        }
    }
    
    var endpointPath: String
    {
        return "\(TodoConstants.TodoAPIEndpoint)\(apiPath)"
    }
}
