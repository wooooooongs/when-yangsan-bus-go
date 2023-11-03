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
    
    static func setDeparture(_ dataDict: [String: String], _ upboundTimetable: inout BusTimetable, _ downboundTimetable: inout BusTimetable) {
        let upboundKey = "ST_DATA0_0"
        let downboundKey = "ST_DATA1_0"
        
        /// - Returns: "부산발"
        guard let upboundName = dataDict[upboundKey],
              let downboundName = dataDict[downboundKey] else { return }
        
        upboundTimetable.departure = upboundName
        downboundTimetable.departure = downboundName
    }
    
    static func setBusTimeData(_ busTypeKeyArray: [String], _ dataDict: [String: String], _ upboundTimetable: inout BusTimetable, _ downboundTimetable: inout BusTimetable) {
        busTypeKeyArray.forEach { busTypeKey in
            guard let busTime = dataDict[busTypeKey] else { return }
            
            let isUpbound = Array(busTypeKey)[7] == "0"
            let isDownbound = Array(busTypeKey)[7] == "1"
            
            if isUpbound {
                if var existingArray = upboundTimetable.buses[busTypeKey] {
                    existingArray.append(busTime)
                    upboundTimetable.buses[busTypeKey] = existingArray
                } else {
                    upboundTimetable.buses[busTypeKey] = []
                }
            }
            
            if isDownbound {
                if var existingArray = downboundTimetable.buses[busTypeKey] {
                    existingArray.append(busTime)
                    downboundTimetable.buses[busTypeKey] = existingArray
                } else {
                    downboundTimetable.buses[busTypeKey] = []
                }
            }
        }
    }
}
