//
//  BusListViewModel.swift
//  whenMyBusGo
//
//  Created by Oscar on 6/14/24.
//

import SwiftUI

class BusListViewModel: ObservableObject {
    @Published var selectedBusType: BusType = .전체
    @Published var selectedBusList: [BusTimetable] = []
    @Published var selectedBus: BusTimetable? = nil
}
