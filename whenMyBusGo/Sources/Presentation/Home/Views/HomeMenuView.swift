//
//  HomeMenuView.swift
//  whenMyBusGo
//
//  Created by Oscar on 4/17/24.
//

import SwiftUI

struct HomeMenuView: View {
    private var safeAreaPadding = 30.0
    private var padding = 15.0
    private var menuSize: CGFloat {
        (UIScreen.main.bounds.width / 2) - (safeAreaPadding + (padding / 2))
    }
    private let menuColumns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    
    // MARK: - Body View
    var body: some View {
        LazyVGrid(columns: menuColumns, spacing: padding) {
            ForEach(Menu.allCases, id: \.self) { menu in
                NavigationLink(destination: menuView(menu)) {
                    menuButton(for: menu)
                }
            }
        }
    }
    
    
    // MARK: - Views
    @ViewBuilder
    private func menuButton(for menuData: Menu) -> some View {
        ZStack {
            Color.white
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    Group {
                        if menuData.isWebView() {
                            webViewBorder()
                        }
                    }
                )
            
            VStack {
                HStack() {
                    Text(menuData.title())
                    // TODO: 디바이스 크기에 맞춰 font 크기 재설정
                        .font(.title)
                        .bold()
                        .padding([.top, .leading], 16)
                    
                    Spacer()
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    if menuData.isWebView() {
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
    private func menuView(_ menu: Menu) -> some View {
        switch menu {
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
