//
//  CoreDataManager.swift
//  whenMyBusGo
//
//  Created by Oscar on 2/14/24.
//

import UIKit
import CoreData
import SwiftUI

final class FavoritedBusDataManager: ObservableObject {
    let modelName: String = "whenMyBusGo"
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Persistent Stores를 불러오는 데 실패했습니다!: \(error.localizedDescription)")
            }
        }
        
        return container
    }()
    
    lazy var viewContext: NSManagedObjectContext = persistentContainer.viewContext
    
    func saveContext() {
        guard viewContext.hasChanges else { return }
        
        do {
            try viewContext.save()
        } catch {
            print("저장에 실패하였습니다:", error.localizedDescription)
        }
    }
    
    // MARK: - CREATE & UPDATE
    func createOrUpdateFavoriteBus(for busData: BusTimetable, isUpbound: Bool) {
        let request: NSFetchRequest<FavoritedBus> = FavoritedBus.fetchRequest()
        request.predicate = NSPredicate(format: "busId == %@", busData.id)
        
        do {
            let result = try viewContext.fetch(request),
                isFavoritedBusDataExist = result.first !== nil
            
            if isFavoritedBusDataExist,
               let favoritedBus = result.first {
                update(for: favoritedBus, isUpbound)
            } else {
                create(for: busData, isUpbound)
            }
        } catch {
            print(error)
        }
        
        saveContext()
    }
    
    func create(for busData: BusTimetable, _ isUpbound: Bool) {
        let newFavoritedBus = FavoritedBus(context: viewContext)
        newFavoritedBus.busNumber = busData.busNumber
        newFavoritedBus.busId = busData.id
        newFavoritedBus.busType = BusType.caseName(for: busData.busType.rawValue)
        newFavoritedBus.upboundName = busData.upbound
        newFavoritedBus.downboundName = busData.downbound
        newFavoritedBus.isUpboundFavorited = isUpbound
        newFavoritedBus.isDownboundFavorited = !isUpbound
        newFavoritedBus.savedDate = .now
        
        print("\(busData.id)가 존재하지 않습니다. 새로 생성합니다.")
    }
    
    func update(for favoritedBus: FavoritedBus, _ isUpbound: Bool) {
        if isUpbound {
            favoritedBus.isUpboundFavorited.toggle()
        } else {
            favoritedBus.isDownboundFavorited.toggle()
        }
        
        let isNotFavoritedAnyDirection: Bool = favoritedBus.isUpboundFavorited == false && favoritedBus.isDownboundFavorited == false
        
        if isNotFavoritedAnyDirection {
            delete(item: favoritedBus)
            print("")
        }
    }
    
    // MARK: - Delete
    func deleteAll(items: [FavoritedBus]) {
        for item in items {
            viewContext.delete(item)
        }
        
        saveContext()
    }
    
    func delete(item: FavoritedBus) {
        viewContext.delete(item)
        
        saveContext()
    }
}
