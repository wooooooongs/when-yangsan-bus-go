//
//  UIView+addBorder.swift
//  whenMyBusGo
//
//  Created by Oscar on 1/6/24.
//

import UIKit

extension UIView {
    func addBorder(_ edges: [UIRectEdge], withColor color: UIColor, width: CGFloat) {
        self.layoutIfNeeded()
        
        for edge in edges {
            let border = CALayer()
            
            switch edge {
            case .all:
                self.layer.borderWidth = width
                break
                
            case .top:
                border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
                break
                
            case .right:
                border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
                break
                
            case .bottom:
                border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
                break
                
            case .left:
                border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
                break
                
            default:
                break
            }
            
            self.layer.borderColor = color.cgColor
            self.layer.addSublayer(border)
        }
    }
}
