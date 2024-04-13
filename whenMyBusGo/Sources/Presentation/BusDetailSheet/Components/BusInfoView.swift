//
//  BusInfoView.swift
//  whenMyBusGo
//
//  Created by Oscar on 4/13/24.
//

import SwiftUI

struct BusInfoView: View {
    @Binding var busData: BusTimetable
    
    var body: some View {
        ZStack {
            Color.yangsan
                .roundedCorner([.topLeft, .topRight], 20)
            
            VStack(spacing: 0) {
                Capsule()
                    .frame(width: 35, height: 5)
                    .padding(.bottom, 20)
                
                HStack {
                    Text("\(busData.busType)")
                        .font(.callout)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    HStack {
                        Image(systemName: "star")
                        
                        Text("\(busData.upbound)")
                            .fontWeight(.bold)
                    }
                    .padding([.top, .bottom], 5)
                    .padding([.leading, .trailing], 7.5)
                    .background(Color.black.opacity(0.25), in: Capsule())
                }
                
                HStack {
                    Text("\(busData.busNumber)")
                        .font(.largeTitle)
                    
                    Spacer()
                }
            }
            .padding()
            .foregroundStyle(.white)
        }
        .frame(maxHeight: 100)
    }
}
