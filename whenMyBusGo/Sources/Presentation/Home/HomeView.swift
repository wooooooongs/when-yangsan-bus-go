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
                
                VStack(alignment: .center, spacing: 25) {
                    HomeMenuView()
                    
                    HomeFavoritedBusListView()
                    
                    Spacer()
                }
                // TODO: padding 재활용
                .safeAreaPadding([.top, .leading, .trailing], 30)
            }
            .navigationTitle("언제 출발해?")
        }
    }
}

extension HomeView {
    
}

private struct HomeMenuView: View {
    var menuDatas: [MenuData] = MenuDatas.shared.getMenuDatas()
    
    var safeAreaPadding = 30.0
    var padding = 15.0
    var menuSize: CGFloat {
        (UIScreen.main.bounds.width / 2) - (safeAreaPadding + (padding / 2))
    }
    let menuColumns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        LazyVGrid(columns: menuColumns, spacing: padding) {
            ForEach(menuDatas.indices, id: \.self) { menuIndex in
                let menuData = menuDatas[menuIndex]
                
                NavigationLink(destination: menuView(menuData)) {
                    menuButton(for: menuData)
                }
            }
        }
    }
    
    @ViewBuilder
    private func menuButton(for menuData: MenuData) -> some View {
        ZStack {
            Color.white
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    Group {
                        if menuData.isWebView {
                            webViewBorder()
                        }
                    }
                )
            
            VStack {
                HStack() {
                    Text(menuData.title.rawValue)
                        .font(.title)
                        .bold()
                        .padding([.top, .leading], 16)
                    
                    Spacer()
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    if menuData.isWebView {
                        Image("yangsan_logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30.0)
                            .padding([.bottom, .trailing], 16)
                    }
                }
            }
        }
        .frame(width: menuSize, height: menuSize)
    }
    
    @ViewBuilder
    private func emptyMenuButton() -> some View {
        ZStack {
            Color.white
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing) // 전체 크기에 맞게 확장하고 내용을 우측 하단에 정렬
    }
    
    @ViewBuilder
    private func menuView(_ menuData: MenuData) -> some View {
        switch menuData.title {
        case .busTimetable:
            BusListView()
        case .location_yangsan:
            BusListView()
        case .notice_yangsan:
            BusListView()
        case .qna:
            BusListView()
        }
    }
    
    @ViewBuilder
    private func webViewBorder() -> some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(.yangsan, lineWidth: 4)
    }
}

private struct HomeFavoritedBusListView: View {
    var body: some View {
        
        ZStack {
            Color.white
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            HStack {
                VStack(alignment: .leading) {
                    Text("좌석 북정발")
                        .font(.caption)
                        .offset(y: 2.5)
                    
                    Text("1200")
                        .font(.largeTitle)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("막차 끊김")
                        .font(.callout)
                    Text("06:55 출발")
                        .font(.callout)
                }
            }
            .padding([.leading, .trailing], 20)
        }
        .frame(maxWidth: .infinity, maxHeight: 70.0)
    }
}

#Preview {
    ContentView()
        .tint(.black)
}
