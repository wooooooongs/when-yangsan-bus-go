//
//  MenuData.swift
//  whenMyBusGo
//
//  Created by Oscar on 2/5/24.
//

import Foundation

struct MenuData {
    var title: String = "메뉴"
    var isWebView: Bool = false
}

struct MenuDatas {
    static var shared = MenuDatas()
    
    func fetchMenuDatas() -> [MenuData] {
        return [
            MenuData(title: "버스 시간표", isWebView: false),
            MenuData(title: "실시간 위치", isWebView: true),
            MenuData(title: "공지사항", isWebView: true),
            MenuData(title: "문의사항", isWebView: false),
        ]
    }
}
