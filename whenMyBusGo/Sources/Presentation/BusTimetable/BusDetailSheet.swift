//
//  BusDetailSheet.swift
//  whenMyBusGo
//
//  Created by Oscar on 4/9/24.
//

import SwiftUI

struct BusDetailSheet: View {
    let setBackground = Color(HexColor.from("EEEEEE"))
    
    @Binding var busData: BusTimetable
    
    var body: some View {
        ZStack {
            setBackground
                .ignoresSafeArea()
            
            VStack {
                busInfo()
                
                timetable()
                    .padding(.top, 10)
                
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
        HStack {
            VStack(alignment: .leading) {
                Text("\(busData.busType)")
                    .font(.headline)
                    .fontWeight(.bold)
                Text("\(busData.busNumber)")
                    .font(.system(size: 48, weight: .bold))
            }
            
            Spacer()
        }
    }
    @ViewBuilder
    private func timetable() -> some View {
        HStack(spacing: 0) {
            upbound()
            
            downbound()
        }
    }
    
    @ViewBuilder
    private func upbound() -> some View {
        VStack(spacing: 0) {
            // header
            ZStack {
                Color.yangsan
                    .overlay {
                        HStack {
                            Image(systemName: "star")
                                .foregroundStyle(.white)
                            
                            Text("\(busData.upbound)")
                                .foregroundStyle(.white)
                                .font(.title3)
                                .fontWeight(.bold)
                            
                            Spacer()
                        }
                        .padding([.top, .bottom, .leading], 10)
                    }
                    .roundedCorner(.topLeft, 20)
            }
            .frame(maxHeight: 50)
            
            // body
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
    
    @ViewBuilder
    private func downbound() -> some View {
        VStack(spacing: 0) {
            // header
            ZStack {
                Color.yangsan
                    .overlay {
                        HStack() {
                            Image(systemName: "star")
                                .foregroundStyle(.white)
                            
                            
                            Text("\(busData.downbound)")
                                .foregroundStyle(.white)
                                .font(.title3)
                                .fontWeight(.bold)
                            
                            Spacer()
                        }
                        .padding([.top, .bottom, .leading], 10)
                    }
                    .roundedCorner(.topRight, 20)
            }
            .frame(maxHeight: 50)
            
            // body
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
