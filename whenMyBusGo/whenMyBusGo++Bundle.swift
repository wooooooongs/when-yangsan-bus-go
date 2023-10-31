//
//  whenMyBusGo++Bundle.swift
//  whenMyBusGo
//
//  Created by Oscar on 10/31/23.
//

import Foundation

extension Bundle {
    var requestUrl: String {
        guard let plistFile = Bundle.main.url(forResource: "UrlList", withExtension: "plist") else {
            fatalError("UrlList.plist 파일을 찾지 못했습니다.")
        }
        guard let plistData = try? Data(contentsOf: plistFile),
              let dict = try? PropertyListSerialization.propertyList(from: plistData, format: nil) as? [String: AnyObject] else {
            fatalError("UrlList.plist 내 Dictionary를 찾지 못했습니다.")
        }
        guard let url = dict["REQUEST_URL"] as? String else {
            fatalError("URL이 존재하지 않습니다. \n UrlList.plist 파일에서 등록해주세요.")
        }

        return url
    }
}
