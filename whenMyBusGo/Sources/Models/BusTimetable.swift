//
//  BusTimetable.swift
//  whenMyBusGo
//
//  Created by Oscar on 10/29/23.
//

import Foundation

struct BusTimetables: Decodable {
    let result: [BusTimetable]
}

struct BusTimetable: Decodable {
    let busNumber: String
    let id: String
    let upbound: String
    let downbound: String
    private let type: String
    var upboundTimetable: [Day: [String]] = [:]
    var downboundTimetable: [Day: [String]] = [:]
    
    var busType: BusType {
        return BusType(rawValue: type) ?? .일반
    }
    
    private enum CodingKeys: String, CodingKey {
        case busNumber, id, upbound, downbound, type, upboundTimetable, downboundTimetable
    }
    
    enum BusType: String {
        case 일반 = "1"
        case 좌석 = "2"
        case 심야 = "3"
        case 급행 = "4"
        case 마을 = "5"
    }
}

extension BusTimetable.BusType {
    static func caseName(for rawValue: String) -> String? {
        return BusTimetable.BusType(rawValue: rawValue)?.caseName
    }
    
    var caseName: String {
            switch self {
            case .일반:
                return "일반"
            case .좌석:
                return "좌석"
            case .심야:
                return "심야"
            case .급행:
                return "급행"
            case .마을:
                return "마을"
            }
        }
}

enum Day: String, Decodable{
    case weekday
    case sat
    case sun
    case weekend
}

enum DayTypeForButton: Int {
    case weekday, sat, sun, weekend
    
    func convertToDay(_ button: DayTypeForButton) -> Day? {
        switch button {
        case .weekday:
            return .weekday
        case .sat:
            return .sat
        case .sun:
            return .sun
        case .weekend:
            return .weekend
        }
    }
}
