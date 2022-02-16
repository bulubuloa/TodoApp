//
//  NavigationRoute.swift
//  TodoApp
//
//  Created by Omnimobile on 2/16/22.
//

import Foundation

protocol Initializable {
  init()
}
enum Screen {
    case MainMenu
    case BuyList
    case SellList
    case CallList
}

extension Screen {
    var StoryboardID: String {
        switch self {
        case .MainMenu:
            return ViewConstants.MainMenuViewController
        case .BuyList:
            return ViewConstants.BuyListViewController
        case .SellList:
            return ViewConstants.SellListViewController
        case .CallList:
            return ViewConstants.CallListViewController
        }
    }
    
    var ViewModelType: AnyClass {
        switch self {
        case .MainMenu:
            return MainMenuViewModel.self
        case .BuyList:
            return BuyListViewModel.self
        case .SellList:
            return SellListViewModel.self
        case .CallList:
            return CallListViewModel.self
        }
    }
}

class NavigationRoute {
    func createInstance<T>(typeThing:T.Type) -> T where T:Initializable {
        return typeThing.init()
    }
}
