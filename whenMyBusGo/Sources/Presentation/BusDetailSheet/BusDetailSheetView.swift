//
//  BusDetailSheet.swift
//  whenMyBusGo
//
//  Created by Oscar on 4/9/24.
//

import SwiftUI

struct BusDetailSheetView: View {    
    @Binding var busData: BusTimetable
    @State var isUpbound: Bool = true
    @State var dayType: Day = .weekday
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                BusInfoView(busData: .constant(busData), isUpbound: .constant(isUpbound))
                
                if isUpbound {
                    TimetableView(timetable: .constant(busData.upboundTimetable[dayType]))
                } else {
                    TimetableView(timetable: .constant(busData.downboundTimetable[dayType]))
                }
                
                FooterView(busData: .constant(busData), selectedDayType: $dayType, isUpbound: $isUpbound)
            }
            .safeAreaPadding(.top, 30)
            .safeAreaPadding([.leading, .trailing], 10)
        }
    }
}

#Preview {
    let manager = BusTimetableManager()
    
    return BusDetailSheetView(busData: .constant(
        manager.busTimetables[0]
    ))
}

