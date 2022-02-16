//
//  ItemToSell+CoreDataProperties.swift
//  TodoApp
//
//  Created by Omnimobile on 2/16/22.
//
//

import Foundation
import CoreData


extension ItemToSell {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemToSell> {
        return NSFetchRequest<ItemToSell>(entityName: "ItemToSell")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var price: Int32
    @NSManaged public var quantity: Int16
    @NSManaged public var type: Int16

}

extension ItemToSell : Identifiable {

}
