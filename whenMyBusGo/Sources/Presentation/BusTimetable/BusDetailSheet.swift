//
//  BusDetailSheet.swift
//  whenMyBusGo
//
//  Created by Oscar on 4/9/24.
//

import SwiftUI

struct BusDetailSheet: View {
    @Binding var busData: BusTimetable
    
    var body: some View {
        ZStack {
            VStack {
                busInfo()
                    .frame(maxHeight: 100)
                
                timetable()
                
                ZStack {
                    Color.white
                        .frame(width: .infinity, height: 50)
                    
                    Text("Footer")
                }
            }
            .safeAreaPadding([.top, .leading, .trailing], 30)
        }
    }
    
    @ViewBuilder
    private func busInfo() -> some View {
        ZStack {
            Color.yangsan
                .roundedCorner([.topLeft, .topRight], 20)
            
            VStack(spacing: 0) {
                Capsule()
                    .frame(width: 35, height: 5)
                    .padding(.bottom, 15)

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
    }
    
    @ViewBuilder
    private func timetable() -> some View {
        VStack {
            ZStack {
                Color.white
                
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(busData.upboundTimetable[.sat]!, id: \.self) { time in
                            Divider()
                                .padding([.leading, .trailing], 20)
                            Text(time)
                                .font(.title3)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    BusDetailSheet(busData: .constant(
        BusTimetableManager.shared.getAllBusTimetables()[0]
    ))
}
