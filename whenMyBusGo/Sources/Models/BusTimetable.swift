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

struct BusTimetable: Decodable, Identifiable {
    let busNumber: String
    let id: String
    let upbound: String
    let downbound: String
    private let type: String
    var upboundTimetable: [Day: [String]] = [:]
    var downboundTimetable: [Day: [String]] = [:]
    
    enum CodingKeys: String, CodingKey {
        case busNumber, id, upbound, downbound, type, upboundTimetable, downboundTimetable
    }
        
    // MARK: - 외부에서 버스 타입 접근
    var busType: BusType {
        return BusType(rawValue: type) ?? .일반
    }
}

enum BusType: String, CaseIterable {
    case 전체 = "0"
    case 일반 = "1"
    case 좌석 = "2"
    case 심야 = "3"
    case 급행 = "4"
    case 마을 = "5"
    
    static func caseName(for rawValue: String) -> String? {
        return BusType(rawValue: rawValue)?.caseName
    }
    
    var caseName: String {
        switch self {
        case .전체:
            return "전체"
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

struct BusTimetableForHomeView {
    var busId: String
    var busNumber: String
    var upbound: String?
    var downbound: String?
    var busType: BusType
    var busTypeCaseName: String
    
    init(busId: String, busNumber: String, upbound: String?, downbound: String?, busType: BusType) {
        self.busId = busId
        self.busNumber = busNumber
        self.upbound = upbound
        self.downbound = downbound
        self.busType = busType
        self.busTypeCaseName = BusType.caseName(for: busType.rawValue) ?? "일반"
    }
}
