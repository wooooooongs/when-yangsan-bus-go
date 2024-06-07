//
//  View+roundSpecificCorners.swift
//  whenMyBusGo
//
//  Created by Oscar on 4/9/24.
//

import SwiftUI

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        
        return Path(path.cgPath)
    }
}

extension View {
    func roundedCorner(_ corners: UIRectCorner, _ radius: CGFloat) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}
