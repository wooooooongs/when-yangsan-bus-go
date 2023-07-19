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
        var currentBusTimetable: [String: [String]]
        
        currentBusTimetable = BusTimetable.timetable[busNumKey] ?? [:]
        
        if busNum == 8 {
            switch currentWeek {
            case "토":
                return currentBusTimetable["saturday"] ?? []
            case "일":
                return currentBusTimetable["sunday"] ?? []
            default:
                return currentBusTimetable["weekday"] ?? []
            }
        } else {
            switch currentWeek {
            case "토":
                return currentBusTimetable["weekend"] ?? []
            case "일":
                return currentBusTimetable["weekend"] ?? []
            default:
                return currentBusTimetable["weekday"] ?? []
            }
        }
    }
}
