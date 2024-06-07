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
    @StateObject var favoritedBusDataManager = FavoritedBusDataManager()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .tint(.black)
                .environmentObject(favoritedBusDataManager)
                .environmentObject(BusTimetableManager())
                .environment(\.managedObjectContext, favoritedBusDataManager.persistentContainer.viewContext)
        }
    }
}
