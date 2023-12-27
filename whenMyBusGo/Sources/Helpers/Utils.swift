//
//  Utils.swift
//  whenMyBusGo
//
//  Created by Oscar on 10/28/23.
//

import Foundation

import UIKit

final class Utils {
    
    static let shared = Utils()
    
    private init() {}
    
    static func convertTimeToSeconds(time: String) -> Int {
        var convertedTime = 0
        
        let splitedTime = time.components(separatedBy: ":")
        
        if let hour = Int(splitedTime[0]), let minute = Int(splitedTime[1]) {
            convertedTime = hour * 60 + minute
        }
        
        return convertedTime
    }
        
    /// - Returns: "토"
    static func getCurrentWeek() -> String {
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "E"
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        
        return formatter.string(from: date)
    }
    
    /// - Returns: 00:00
    static func getCurrentTime() -> String {
        let date = Date()
        let formatter = DateFormatter()
        var formattedCurrentDate = ""
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        
        formattedCurrentDate = formatter.string(from: date)
        
        return formattedCurrentDate
    }
    
    static func resizeSystemImage(_ imageString: String, to newSize: CGFloat) -> UIImage? {
        guard let originalImage = UIImage(systemName: imageString) else { return nil }
        let aspectRatio = originalImage.size.width / originalImage.size.height
        
        let newHeight = newSize / aspectRatio
        let newImageSize = CGSize(width: newSize, height: newHeight)
        
        let renderer = UIGraphicsImageRenderer(size: newImageSize)
        let newImage = renderer.image { _ in
            originalImage.draw(in: CGRect(origin: .zero, size: newImageSize))
        }
        
        return newImage
    }
}
