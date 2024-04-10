//
//  BusDetailSheet.swift
//  whenMyBusGo
//
//  Created by Oscar on 4/9/24.
//

import SwiftUI

struct BusDetailSheetView: View {
    @Binding var busData: BusTimetable
    
    var body: some View {
        ZStack {
            VStack {
                busInfo()
                    .frame(maxHeight: 100)
                
                timetable(busData.upboundTimetable[.sat])
                    .background(.white, ignoresSafeAreaEdges: [])
                
                // footer
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
    private func timetable(_ timetable: [String]?) -> some View {
        let morningTimes = timetable?.filter { time in
            guard let hour = Int(time.prefix(2)) else { return false }
            
            return hour < 12
        } ?? ["시간표가 비어있습니다."]

        let afternoonTimes = timetable?.filter { time in
            guard let hour = Int(time.prefix(2)) else { return false }
            
            return hour >= 12
        } ?? ["시간표가 비어있습니다."]

        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        
        ScrollView {
            VStack(alignment: .leading) {
                Text("오전")
                    .font(.title)
                    .fontWeight(.semibold)
                
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(morningTimes, id: \.self) { time in
                            Text(time)
                                .font(.title2)
                    }
                }
                
                Divider()
                    .padding([.top, .bottom])
                
                Text("오후")
                    .font(.title)
                    .fontWeight(.semibold)

                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(afternoonTimes, id: \.self) { time in
                            Text(time)
                                .font(.title2)
                    }
                }
            }
            .padding()
        }
        .background(.white, ignoresSafeAreaEdges: [])
    }
}

#Preview {
    BusDetailSheetView(busData: .constant(
        BusTimetableManager.shared.getAllBusTimetables()[0]
    ))
}
