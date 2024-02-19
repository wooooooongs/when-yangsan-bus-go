//
//  BusTimetableManager.swift
//  whenMyBusGo
//
//  Created by 이재웅 on 2023/07/19.
//

import Foundation

class BusTimetableManager {
    static let shared = BusTimetableManager()
    private let coreDataManager = CoreDataManager.shared
    
    private init() {
        decodeDataFromBusDatas()
        convertFavoritedBusToBusTimetable()
    }
    
    private var busTimetables: [BusTimetable] = []
    private var convertedFavoritedBusArray: [BusTimetableForHomeView] = []
    
    func getAllBusTimetables() -> [BusTimetable] {
        return busTimetables
    }
    
    func getConvertedFavoritedBusArray() -> [BusTimetableForHomeView] {
        return convertedFavoritedBusArray
    }
        
    // MARK: - Functions
    private func decodeDataFromBusDatas() {
        guard let jsonPath = Bundle.main.path(forResource: "busDatas", ofType: "json") else { return }
        let decoder = JSONDecoder()
        
        do {
            let url = URL(filePath: jsonPath)
            let data = try Data(contentsOf: url)
            
            let decodedData = try decoder.decode(BusTimetables.self, from: data)
            
            return busTimetables = decodedData.result
        } catch {
            print("busDatas.json이 없는 거 같은데용")
        }
    }
    
    private func convertFavoritedBusToBusTimetable() {
        let favoritedBusArray = coreDataManager.getAllFavoritedBus()
        
        for favoritedBus in favoritedBusArray {
            guard let busId = favoritedBus.id else { return }
            
            if let busTimetable = busTimetables.first(where: { $0.id == busId }) {
                let busNumber = busTimetable.busNumber
                let busType = busTimetable.busType
                var busDirection: String?
                
                if favoritedBus.upbound {
                    busDirection = busTimetable.upbound
                }
                
                if favoritedBus.downbound {
                    busDirection = busTimetable.downbound
                }
                
                let busTimetableForHomeView = BusTimetableForHomeView(busNumber: busNumber, upbound: busDirection, downbound: busDirection, busType: BusType(rawValue: busType.rawValue) ?? .일반)
                convertedFavoritedBusArray.append(busTimetableForHomeView)
            }
        }
    }
}
