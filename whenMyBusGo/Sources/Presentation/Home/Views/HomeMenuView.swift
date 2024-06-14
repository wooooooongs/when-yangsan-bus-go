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
        (SCREEN_WIDTH / 2) - (safeAreaPadding + (padding / 2))
    }
    private var menuColumns: [GridItem] { Array(
        repeating: .init(.fixed(menuSize)),
        count: 2
    )}
    
    
    // MARK: - Body View
    var body: some View {
        LazyVGrid(columns: menuColumns, spacing: padding) {
            ForEach(Menu.allCases, id: \.self) { menu in
                // TODO: #10
                NavigationLink(value: menu) {
                    VStack {
                        title(menu.title)
                        
                        Spacer()
                        
                        if menu.isWebView {
                            image
                        }
                    }
                    .padding(16)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay {
                        webViewBorder(menu.isWebView)
                    }
                    .frame(width: menuSize, height: menuSize)
                }
            }
        }
        .navigationDestination(for: Menu.self) { menu in
            menuView(menu)
        }
    }
    
    
    // MARK: - Views
    @ViewBuilder
    private func title(_ titleString: String) -> some View {
        Text(titleString)
            .font(.title.bold())
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    private var image: some View {
        Group {
            Image("yangsan_logo")
                .resizable()
                .scaledToFit()
                .frame(width: 30)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
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
    private func webViewBorder(_ isWebView: Bool) -> some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(.yangsan, lineWidth: isWebView ? 4 : 0)
    }
}
