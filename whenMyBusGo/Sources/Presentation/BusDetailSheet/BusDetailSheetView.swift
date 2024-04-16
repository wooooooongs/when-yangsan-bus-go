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
                BusInfoView(busData: $busData)
                
                TimetableView(timetable: $busData.upboundTimetable[.sat])
                
                // footer
                ZStack {
                    Color.white
                        .frame(width: .infinity, height: 50)
                    
                    Text("Footer")
                }
            }
            .safeAreaPadding(.top, 30)
            .safeAreaPadding([.leading, .trailing], 10)
        }
    }
}

#Preview {
    BusDetailSheetView(busData: .constant(
        BusTimetableManager.shared.getAllBusTimetables()[0]
    ))
}
