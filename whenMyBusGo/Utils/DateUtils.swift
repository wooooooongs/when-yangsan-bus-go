//
//  DateUtils.swift
//  whenMyBusGo
//
//  Created by 이재웅 on 2023/07/18.
//

import Foundation

class DateUtils {
    /// - Returns: ["00:00", "01:00", ...]
    static func fetchTodayBusTime() -> [String] {
        let date = Date()
        let formatter = DateFormatter()
        var currentWeek = ""
        
        formatter.dateFormat = "E"
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        
        currentWeek = formatter.string(from: date)
        
        switch currentWeek {
        case "토":
            return BusTimetable.saturday
        case "일":
            return BusTimetable.sunday
        default:
            return BusTimetable.weekday
        }
    }
    
    /// - Returns: 00:00
    static func getCurrentTime() -> String {
        let date = Date()
        let formatter = DateFormatter()
        var formattedCurrentDate = ""
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        
        formattedCurrentDate = formatter.string(from: date)
        
        return formattedCurrentDate
    }
    
}
