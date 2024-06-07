//
//  HomeView.swift
//  whenMyBusGo
//
//  Created by Oscar on 3/23/24.
//

import SwiftUI

struct HomeView: View {
    let setBackground = Color(HexColor.from("EEEEEE"))
    
    var body: some View {
        NavigationStack {
            ZStack {
                setBackground
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .center, spacing: 25) {
                        HomeMenuView()
                        
                        HomeFavoritedBusListView()
                    }
                    // TODO: padding 재활용
                    .safeAreaPadding([.top, .leading, .trailing], 30)
                }
            }
            .navigationTitle("언제 출발해?")
        }
    }
}


#Preview {
    HomeView()
        .tint(.black)
        .environmentObject(BusTimetableManager())
}
