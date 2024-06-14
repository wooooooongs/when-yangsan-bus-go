//
//  BusListViewModel.swift
//  whenMyBusGo
//
//  Created by Oscar on 6/14/24.
//

import SwiftUI

class BusListViewModel: ObservableObject {
    @Published var currentBusType: BusType = .전체
    @Published var currentBusList: [BusTimetable] = []
    @Published var currentBus: BusTimetable? = nil
}
