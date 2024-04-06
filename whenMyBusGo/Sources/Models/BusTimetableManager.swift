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
    
    func getBusTimetables(forType busType: BusType) -> [BusTimetable] {
        if busType == .전체 {
            return busTimetables
        }
        
        return busTimetables.filter {
            $0.busType == busType
        }
    }
    
    func getConvertedFavoritedBusArray() -> [BusTimetableForHomeView] {
        self.convertFavoritedBusToBusTimetable()
        return convertedFavoritedBusArray
    }
    
    // MARK: - Methods
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
        var convertedFavoritedBusArrayTemp: [BusTimetableForHomeView] = []
        
        for favoritedBus in favoritedBusArray {
            guard let busId = favoritedBus.id else { return }
            
            if let busTimetable = busTimetables.first(where: { $0.id == busId }) {
                let busId = busTimetable.id
                let busNumber = busTimetable.busNumber
                let busType = busTimetable.busType
                
                if favoritedBus.upbound {
                    let busTimetableForHomeView = BusTimetableForHomeView(busId: busId, busNumber: busNumber, upbound: busTimetable.upbound, downbound: "", busType: BusType(rawValue: busType.rawValue) ?? .일반)
                    convertedFavoritedBusArrayTemp.append(busTimetableForHomeView)
                }
                
                if favoritedBus.downbound {
                    let busTimetableForHomeView = BusTimetableForHomeView(busId: busId, busNumber: busNumber, upbound: "", downbound: busTimetable.downbound, busType: BusType(rawValue: busType.rawValue) ?? .일반)
                    convertedFavoritedBusArrayTemp.append(busTimetableForHomeView)
                }
                
                convertedFavoritedBusArray = convertedFavoritedBusArrayTemp
            }
        }
    }
    
    func getBusTimetableToBusId(_ busId: String) -> BusTimetable? {
        return busTimetables.first(where: { $0.id == busId })
    }
}
