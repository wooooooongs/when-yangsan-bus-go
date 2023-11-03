//
//  BusTimetable.swift
//  whenMyBusGo
//
//  Created by Oscar on 10/29/23.
//

import Foundation

struct BusTimetables {
    var busNumber: String = ""
    var timetable: [BusTimetable] = []
}

struct BusTimetable {
    var departure: String = ""
    var buses: [String: [String]] = [:]
}
