//
//  View+TransparentSheetBackground.swift
//  whenMyBusGo
//
//  Created by Oscar on 6/15/24.
//

import SwiftUI

extension View {
    func transparentSheetBackground() -> some View {
        self.modifier(TransparentSheetBackgroundViewModifier())
    }
}

// MARK: - ViewModifier
struct TransparentSheetBackgroundViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.4, *) {
            content
                .presentationBackground(.clear)
        } else {
            content
                .background(TransparentBackgroundView())
        }
    }
}

// MARK: - UIView
struct TransparentBackgroundView: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
