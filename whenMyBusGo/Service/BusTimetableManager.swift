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
        var currentBusTimetable: [String: [String]] = [:]
        
        switch busNum {
        case 8:
            currentBusTimetable = BusTimetable.bus8
        case 1100:
            currentBusTimetable = BusTimetable.bus1100
        case 1200:
            currentBusTimetable = BusTimetable.bus1200
        default:
            currentBusTimetable = [:]
        }
        
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
