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
        NavigationStack {
            ZStack {
                background
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .center, spacing: 25) {
                        HomeMenuView()
                        
                        HomeFavoritedBusListView()
                    }
                    .safeAreaPadding(.horizontal)
                }
            }
            .navigationTitle("언제 출발해?")
        }
    }
    
    
    // MARK: - Views
    private var background: Color {
        Color(hex: "EEEEEE")
    }
}


#Preview {
    HomeView()
        .tint(.black)
        .environmentObject(BusTimetableManager())
}
