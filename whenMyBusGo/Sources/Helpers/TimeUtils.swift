//
//  Utils.swift
//  whenMyBusGo
//
//  Created by Oscar on 10/28/23.
//

import Foundation

import UIKit

final class TimeUtils {
    
    static let shared = TimeUtils()
    
    private init() {}
    
    /// - Returns: 02:30 -> 150
    func convertTimeToMinutes(_ time: String) -> Int {
        var convertedTime = 0
        
        let splitedTime = time.components(separatedBy: ":")
        
        if let hour = Int(splitedTime[0]), let minute = Int(splitedTime[1]) {
            convertedTime = hour * 60 + minute
        }
        
        return convertedTime
    }
        
    /// - Returns: "토"
    func getCurrentWeek() -> String {
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "E"
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        
        return formatter.string(from: date)
    }
    
    /// - Returns: 11:30
    func getCurrentTime() -> String {
        let date = Date()
        let formatter = DateFormatter()
        var formattedCurrentDate = ""
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        
        formattedCurrentDate = formatter.string(from: date)
        
        return formattedCurrentDate
    }
    
    func isBusPassed(_ time: String) -> Bool {
        let convertedTime = convertTimeToMinutes(time)
        let currentTimeString = getCurrentTime()
        let currentTime = convertTimeToMinutes(currentTimeString)

        let isBusGone = currentTime > convertedTime
        
        return isBusGone
    }
}
