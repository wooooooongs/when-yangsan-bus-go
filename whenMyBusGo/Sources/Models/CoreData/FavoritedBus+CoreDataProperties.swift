//
//  FavoritedBus+CoreDataProperties.swift
//  whenMyBusGo
//
//  Created by Oscar on 2/15/24.
//
//

import Foundation
import CoreData


extension FavoritedBus {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritedBus> {
        return NSFetchRequest<FavoritedBus>(entityName: "FavoritedBus")
    }

    @NSManaged public var upbound: Bool
    @NSManaged public var id: String?
    @NSManaged public var downbound: Bool
    @NSManaged public var savedDate: Date?
}

extension FavoritedBus : Identifiable {

}
