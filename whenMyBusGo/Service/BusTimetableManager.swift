//
//  BusTimetableManager.swift
//  whenMyBusGo
//
//  Created by 이재웅 on 2023/07/19.
//

import Foundation

class BusTimetableManager {
    /// - Returns: ["00:00", "01:00", ...]
    static func getTodayBusTime() -> [String] {
        var currentWeek = DateUtils.getCurrentWeek()
        
        switch currentWeek {
        case "토":
            return BusTimetable.saturday
        case "일":
            return BusTimetable.sunday
        default:
            return BusTimetable.weekday
        }
    }
}
