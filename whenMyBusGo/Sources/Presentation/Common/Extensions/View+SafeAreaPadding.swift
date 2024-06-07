//
//  View+SafeAreaPadding.swift
//  whenMyBusGo
//
//  Created by Oscar on 6/7/24.
//

import SwiftUI

struct SafeAreaPadding: ViewModifier {
    let length: CGFloat = 30
    var axisType: AxisType
    
    func body(content: Content) -> some View {
        switch axisType {
        case .horizontal:
            content.padding(.horizontal, length)
        case .vertical:
            content.padding(.vertical, length)
        case .none:
            content
        }
    }
}

struct IgnoreSafeAreaPadding: ViewModifier {
    let length: CGFloat = 30
    var axisType: AxisType
    
    func body(content: Content) -> some View {
        switch axisType {
        case .horizontal:
            content.padding(.horizontal, -length)
        case .vertical:
            content.padding(.vertical, -length)
        case .none:
            content
        }
    }
}

extension View {
    func safeAreaPadding(_ type: AxisType) -> some View {
        self.modifier(SafeAreaPadding(axisType: type))
    }
    
    func ignoreSafeArePadding(_ type: AxisType) -> some View {
        self.modifier(IgnoreSafeAreaPadding(axisType: type))
    }
}

enum AxisType {
    case horizontal, vertical, none
}
