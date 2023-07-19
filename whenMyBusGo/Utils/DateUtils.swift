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
        var currentWeek = getCurrentWeek()
        
        switch currentWeek {
        case "토":
            return BusTimetable.saturday
        case "일":
            return BusTimetable.sunday
        default:
            return BusTimetable.weekday
        }
    }
    
    /// - Returns: "토"
    static func getCurrentWeek() -> String {
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "E"
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        
        return formatter.string(from: date)
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
