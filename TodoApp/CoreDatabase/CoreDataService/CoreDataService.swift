//
//  CoreDataService.swift
//  TodoApp
//
//  Created by Omnimobile on 2/16/22.
//

import Foundation
import CoreData
import SwiftUI

enum CoreDataError: Error {
    case feetchError
    case unknow
}

class CoreDataManager {
    private let module: String
    
    init(module: String) {
        self.module = module
    }
    
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.module)
        container.loadPersistentStores {
            (description, error) in
            if let error = error as NSError? {
                print(error)
            }
        }
        return container
    }()
    
    lazy var mainContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    func saveChanges() -> Bool {
        guard mainContext.hasChanges else {
            return true
        }
        do {
            try mainContext.save()
            return true
        } catch let error as NSError {
            print(error)
            return false
        }
    }
}
