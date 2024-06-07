//
//  HomeMenuView.swift
//  whenMyBusGo
//
//  Created by Oscar on 4/17/24.
//

import SwiftUI

struct HomeMenuView: View {
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
                    // TODO: 디바이스 크기에 맞춰 font 크기 재설정
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

#Preview {
    HomeMenuView()
}
