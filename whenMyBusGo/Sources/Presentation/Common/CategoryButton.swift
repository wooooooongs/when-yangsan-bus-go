//
//  CategoryButton.swift
//  whenMyBusGo
//
//  Created by Oscar on 4/16/24.
//

import SwiftUI

struct CategoryButton<T: Hashable>: View {
    var title: String
    @Binding var selectedItem: T
    var item: T
    
    var body: some View {
        Text("\(title)")
            .font(.callout)
            .fontWeight(.medium)
            .foregroundColor(
                selectedItem == item ? .white : .black
            )
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(Capsule()
                .fill(selectedItem == item ? .yangsan : .white)
            )
    }
}
