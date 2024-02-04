//
//  HexColor.swift
//  whenMyBusGo
//
//  Created by Oscar on 2/4/24.
//

import UIKit

class HexColor {
    static func from(_ hex: String, alpha: CGFloat = 1.0) -> UIColor {
        let hexString: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        
        if hexString.hasPrefix("#") {
            scanner.currentIndex = hexString.index(after: hexString.startIndex)
        }
        
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        
        let mask = 0x000000FF
        let red   = CGFloat(Int(color >> 16) & mask) / 255.0
        let green = CGFloat(Int(color >> 8) & mask) / 255.0
        let blue  = CGFloat(Int(color) & mask) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
