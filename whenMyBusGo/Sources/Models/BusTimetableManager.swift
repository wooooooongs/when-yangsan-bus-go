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
    
    func calcNextBusTime(busData: BusTimetable, _ isUpbound: Bool) -> String {
        let now = Date()
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: now)
        let minute = calendar.component(.minute, from: now)
        let weekday = calendar.component(.weekday, from: now)
        let currentTimeString = String(format: "%02d:%02d", hour, minute)
        
        
        let day: Day
        
        if busData.isDayTypeSeperated ?? true {
            switch weekday {
            case 1...5:
                day = .weekday
            case 6:
                day = .sat
            case 7:
                day = .sun
            default:
                fatalError("버스 데이터에 문제가 있습니다.")
            }
        } else {
            switch weekday {
            case 1...5:
                day = .weekday
            case 6, 7:
                day = .weekend
            default:
                fatalError("버스 데이터에 문제가 있습니다.")
            }
        }
        
        let timeTable = isUpbound ? busData.upboundTimetable : busData.downboundTimetable

        guard let dayTimetable = timeTable[day] else {
            return "버스 데이터에 문제가 있습니다."
        }

        for busTime in dayTimetable {
            if busTime > currentTimeString {
                print(busTime)
                return busTime
            }
        }
        
        return ""
    }
}
