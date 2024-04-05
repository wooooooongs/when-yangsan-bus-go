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
        ZStack {
            setBackground
            
            VStack(alignment: .center, spacing: 25) {
                HomeMenuView()
                
                HomeFavoritedBusListView()
                
                Spacer()
            }
            .safeAreaPadding([.leading, .trailing], 30)
        }
        .ignoresSafeArea()
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
    
    var body: some View {
        VStack(spacing: padding) {
            ForEach(0..<2) { rowIndex in
                HStack(spacing: padding) {
                    ForEach(0..<2) { columnIndex in
                        let menuIndex: Int? = rowIndex * 2 + columnIndex
                        if let unwrappedMenuIndex = menuIndex, unwrappedMenuIndex < menuDatas.count {
                            menuButton(for: menuDatas[unwrappedMenuIndex])
                        } else {
                            emptyMenuButton()
                        }
                    }
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

            VStack() {
                HStack() {
                    Text(menuData.title.rawValue)
                        .font(.title)
                        .bold()
                        .padding([.top, .leading], 16)
                    
                    Spacer()
                }
                
                Spacer()
                
                HStack() {
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
    private func webViewBorder() -> some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(.yangsan, lineWidth: 4)
    }
}

private struct HomeFavoritedBusListView: View {
    var body: some View {
        
        VStack {
            RoundedRectangle(cornerRadius: 10.0)
                .frame(height: 50.0)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ContentView()
}
