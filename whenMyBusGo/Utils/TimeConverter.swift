//
//  TimeParser.swift
//  whenMyBusGo
//
//  Created by 이재웅 on 2023/07/18.
//

import Foundation

class TimeConverter {
    static func convertTimeToSeconds(time: String) -> Int {
        var convertedTime = 0
        
        let splitedTime = time.components(separatedBy: ":")
        
        if let hour = Int(splitedTime[0]), let minute = Int(splitedTime[1]) {
            convertedTime = hour * 60 + minute
        }
        
        return convertedTime
    }
}
