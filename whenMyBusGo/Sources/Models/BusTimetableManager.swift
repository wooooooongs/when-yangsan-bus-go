//
//  BusTimetableManager.swift
//  whenMyBusGo
//
//  Created by 이재웅 on 2023/07/19.
//

import Foundation

class BusTimetableManager: ObservableObject {
    @Published var busTimetables: [BusTimetable] = []
    @Published var convertedFavoritedBusArray: [BusTimetableForHomeView] = []
    
    init() {
        decodeDataFromBusDatas()
    }
    
    // MARK: - Methods
    func getBusTimetableDatas(forType busType: BusType) -> [BusTimetable] {
        if busType == .전체 {
            return busTimetables
        }
        
        return busTimetables.filter {
            $0.busType == busType
        }
    }
    
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
    
    func getBusTimetableToBusId(_ busId: String) -> BusTimetable? {
        return busTimetables.first(where: { $0.id == busId })
    }
    
    func convertToBusTimetable(from favoritedBus: FavoritedBus) -> BusTimetable? {
        self.busTimetables.filter { busData in
            busData.id == favoritedBus.busId
        }.first
    }
}
