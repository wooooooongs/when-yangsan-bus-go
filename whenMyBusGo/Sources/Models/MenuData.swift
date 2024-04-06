//
//  MenuData.swift
//  whenMyBusGo
//
//  Created by Oscar on 2/5/24.
//

import Foundation

struct MenuData {
    var title: MenuString
    var isWebView: Bool = false
    
}

enum MenuString: String {
    case busTimetable = "버스 목록"
    case location_yangsan = "실시간 위치"
    case notice_yangsan = "공지사항"
    case qna = "문의사항"
}

struct MenuDatas {
    static var shared = MenuDatas()
    private init() {}
    
    func getMenuDatas() -> [MenuData] {
        return [
            MenuData(title: .busTimetable, isWebView: false),
            MenuData(title: .location_yangsan, isWebView: true),
            MenuData(title: .notice_yangsan, isWebView: true),
            MenuData(title: .qna, isWebView: false),
        ]
    }
}
