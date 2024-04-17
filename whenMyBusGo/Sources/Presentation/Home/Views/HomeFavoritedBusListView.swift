//
//  HomeFavoritedBusListView.swift
//  whenMyBusGo
//
//  Created by Oscar on 4/17/24.
//

import SwiftUI

struct HomeFavoritedBusListView: View {
    var body: some View {
        
        ZStack {
            Color.white
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            HStack {
                VStack(alignment: .leading) {
                    Text("좌석 북정발")
                        .font(.caption)
                        .offset(y: 2.5)
                    
                    Text("1200")
                        .font(.largeTitle)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("막차 끊김")
                        .font(.callout)
                    Text("06:55 출발")
                        .font(.callout)
                }
            }
            .padding([.leading, .trailing], 20)
        }
        .frame(maxWidth: .infinity, maxHeight: 70.0)
    }
}

#Preview {
    HomeFavoritedBusListView()
}
