//
//  HomeView.swift
//  whenMyBusGo
//
//  Created by Oscar on 3/23/24.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: - Body View
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                HomeMenuView()
                
                HomeFavoritedBusListView()
            }
            .safeAreaPadding(.horizontal)
            .padding(.top, 20)
        }
        .background(.appBackground)
    }
    
}


#Preview {
    NavigationStack {
        HomeView()
            .navigationTitle("언제 출발해?")
    }
    .environmentObject(FavoritedBusDataManager())
    .environmentObject(BusTimetableManager())
    .environment(\.managedObjectContext, FavoritedBusDataManager().persistentContainer.viewContext)
    .tint(.black)
}
