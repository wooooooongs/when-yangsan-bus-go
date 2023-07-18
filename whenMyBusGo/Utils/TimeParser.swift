//
//  TimeParser.swift
//  whenMyBusGo
//
//  Created by 이재웅 on 2023/07/18.
//

import Foundation

class TimeParser {
    var parsedTime = 0
    
    func parseTime(time: String) -> Int {
        let splitedTime = time.components(separatedBy: ":")
        
        if let hour = Int(splitedTime[0]), let minute = Int(splitedTime[1]) {
            parsedTime = hour * 60 + minute
        }
        
        return parsedTime
    }
}
