//
//  WhenYangsanBusGoApp.swift
//  whenMyBusGo
//
//  Created by Oscar on 3/23/24.
//

import SwiftUI
import CoreData

@main
struct WhenYangsanBusGoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .tint(.black)
                .environmentObject(BusTimetableManager())
        }
    }
}
