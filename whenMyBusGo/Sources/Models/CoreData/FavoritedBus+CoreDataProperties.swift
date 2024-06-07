//
//  FavoritedBus+CoreDataProperties.swift
//  whenMyBusGo
//
//  Created by Oscar on 4/20/24.
//
//

import Foundation
import CoreData


extension FavoritedBus {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritedBus> {
        return NSFetchRequest<FavoritedBus>(entityName: "FavoritedBus")
    }

    @NSManaged public var busId: String?
    @NSManaged public var busNumber: String?
    @NSManaged public var busType: String?
    @NSManaged public var downboundName: String?
    @NSManaged public var isDownboundFavorited: Bool
    @NSManaged public var isUpboundFavorited: Bool
    @NSManaged public var savedDate: Date?
    @NSManaged public var upboundName: String?

}

extension FavoritedBus : Identifiable {

}
