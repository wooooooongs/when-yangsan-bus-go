//
//  CoreDataManager.swift
//  whenMyBusGo
//
//  Created by Oscar on 2/14/24.
//

import UIKit
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {
        fetchAllFavoritedBus()
    }
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    lazy var context = self.appDelegate?.persistentContainer.viewContext
    let modelName: String = "FavoritedBus"
    
    private var favoritedBusArray: [FavoritedBus] = []
    
    func getAllFavoritedBus() -> [FavoritedBus] {
        fetchAllFavoritedBus()
        return self.favoritedBusArray
    }
    
    // MARK: - CREATE & UPDATE
    func saveOrUpdateFavoriteBus(for currentBusData: BusTimetable, isUpbound: Bool) {
        let request: NSFetchRequest<FavoritedBus> = FavoritedBus.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", currentBusData.id)
        guard let context = context else { return }
        
        do {
            let result = try context.fetch(request)
            
            if let favoriteBus = result.first {
                // UPDATE
                if isUpbound {
                    favoriteBus.isUpboundFavorited.toggle()
                    print("\(currentBusData.id) 상행 업데이트 완료")
                } else {
                    favoriteBus.isDownboundFavorited.toggle()
                    print("\(currentBusData.id) 하행 업데이트 완료")
                }
                
                favoriteBus.savedDate = .now
                
            } else {
                // CREATE
                if let entity = NSEntityDescription.entity(forEntityName: self.modelName, in: context),
                   let favoritedBus = NSManagedObject(entity: entity, insertInto: context) as? FavoritedBus {
                    
                    favoritedBus.busId = currentBusData.id
                    favoritedBus.isUpboundFavorited = isUpbound
                    favoritedBus.isDownboundFavorited = !isUpbound
                    favoritedBus.savedDate = .now
                }
            }
            
            if context.hasChanges {
                do {
                    try context.save()
                    print("\(currentBusData.id) 저장 완료")
                } catch {
                    print("\(currentBusData) 데이터를 코어데이터 저장에 실패했습니다.")
                }
            }
            
        } catch {
            print("코어데이터 Update 실패")
        }
    }
    
    // MARK: - READ
    func getFavoriteBus(for busId: String) -> FavoritedBus? {
        var favoriteBus: FavoritedBus?
        
        let request: NSFetchRequest<FavoritedBus> = FavoritedBus.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", busId)
        
        do {
            let results = try context?.fetch(request)
            
            if let favorite = results?.first {
                favoriteBus = favorite
            }
            
        } catch {
            print("코어데이터 Get 실패")
        }
        
        return favoriteBus
    }
    
    func fetchAllFavoritedBus() {
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            let favoritedDate = NSSortDescriptor(key: "savedDate", ascending: true)
            request.sortDescriptors = [favoritedDate]
            
            do {
                if let fetchedFavoritedBusList = try context.fetch(request) as? [FavoritedBus] {
                    favoritedBusArray = fetchedFavoritedBusList
                }
            } catch {
                print("즐겨찾기 된 버스를 가져오는 데 실패했습니다!")
            }
        }
    }
    
    // MARK: - DELETE
    func deleteAllFavoritedToBusId(_ busData: FavoritedBus) {
        guard let busId = busData.busId else { return }
        
        if let context = context {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: self.modelName)
            request.predicate = NSPredicate(format: "id = %@", busId)
            
            do {
                if let fetchedFavoritedBusList = try context.fetch(request) as? [FavoritedBus] {
                    fetchedFavoritedBusList.forEach { bus in
                        context.delete(bus)
                    }
                    if context.hasChanges {
                        do {
                            try context.save()
                            print(context)
                        } catch {
                            print(error)
                        }
                    }
                    
                    print("즐겨찾기 된 버스 데이터를 전부 삭제했습니다.")
                }
            } catch {
                print("즐겨찾기 된 버스 데이터 삭제를 실패했습니다!")
            }
        }
    }
    
    func deleteAllFavoritedToBusId(_ busId: String) {
        if let context = context {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: self.modelName)
            request.predicate = NSPredicate(format: "id = %@", busId)
            
            do {
                if let fetchedFavoritedBusList = try context.fetch(request) as? [FavoritedBus] {
                    fetchedFavoritedBusList.forEach { bus in
                        context.delete(bus)
                    }
                    if context.hasChanges {
                        do {
                            try context.save()
                            print(context)
                        } catch {
                            print(error)
                        }
                    }
                    
                    print("즐겨찾기 된 버스 데이터를 전부 삭제했습니다.")
                }
            } catch {
                print("즐겨찾기 된 버스 데이터 삭제를 실패했습니다!")
            }
        }
    }
}

