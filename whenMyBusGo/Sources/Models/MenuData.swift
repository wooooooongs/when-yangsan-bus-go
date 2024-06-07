//
//  MenuData.swift
//  whenMyBusGo
//
//  Created by Oscar on 2/5/24.
//

enum Menu: CaseIterable {
    case busTimetable
    case location_yangsan
    case notice_yangsan
    case qna
    
    var title: String {
        switch self {
        case .busTimetable:
            "버스 목록"
        case .location_yangsan:
            "실시간 위치"
        case .notice_yangsan:
            "공지사항"
        case .qna:
            "문의사항"
        }
    }
    
    var isWebView: Bool {
        switch self {
        case .busTimetable: false
        case .location_yangsan: true
        case .notice_yangsan: true
        case .qna: false
        }
    }
}
