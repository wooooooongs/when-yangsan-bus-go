//
//  BusTimetableManager.swift
//  whenMyBusGo
//
//  Created by 이재웅 on 2023/07/19.
//

import Foundation

class BusTimetableManager {
    /// - Returns: ["00:00", "01:00", ...]
    static func getTodayBusTime(busNum: Int) -> [String] {
        let currentWeek = DateUtils.getCurrentWeek()
        let busNumKey = "bus\(busNum)"
        guard let currentBusTimetable = BusTimetable.timetable[busNumKey] else {
            return []
        }
                
        var timetableKey = "weekday"
        
        if busNum == 8 {
            switch currentWeek {
            case "토":
                timetableKey = "saturday"
            case "일":
                timetableKey = "sunday"
            default:
                timetableKey = "weekday"
            }
        } else {
            let isWeekend = currentWeek == "토" || currentWeek == "일"
            
            if isWeekend {
                timetableKey = "weekend"
            }
        }
    
        return currentBusTimetable[timetableKey] ?? []
    }
    
    static func convertBusDatas(timeString: [String]) -> [Int] {
        return timeString.map(TimeConverter.convertTimeToSeconds)
    static func setBusNumber(_ dataDict: [String: String], _ timeTables: inout BusTimetables) {
        if let busNumber = dataDict["SVR_LINENAME"] {
            timeTables.busNumber = busNumber
        }
    }
}
